require 'json'
require 'sinatra'
require 'sinatra/activerecord'
require 'sekrets'

require './config/database'
require './config/secret'

Dir['./app/models/*.rb'].each { |file| require file }
Dir['./app/services/**/*.rb'].each { |file| require file }

class App < Sinatra::Base
    get '/' do
        "Hello World!"
    end

    post '/webhook' do
        result = parse_body(request)
        if result['contexts'].present?
            response = InterpretService.call(result['action'], result['contexts'][0]['parameters'])
        else
            response = InterpretService.call(result['action'], result['parameters'])
        end
        mount_response(response)
    end

    post '/webhook_translate' do
        result = parse_body(request)
        if result['contexts'].present?
            response = TranslateModule::HelpService.call() if result['action'] == 'help'
            response = TranslateModule::TranslateService.new(result['contexts'][0]['parameters']).call() if result['action'] == 'translate'
        else
            response = TranslateModule::HelpService.call() if result['action'] == 'help'
            response = TranslateModule::TranslateService.new(result['parameters']).call() if result['action'] == 'translate'
        end
        mount_response(response)
    end

    private
        def parse_body(request)
            request.body.rewind
            JSON.parse(request.body.read)['queryResult']
        end

        def mount_response(response)
            content_type :json, charset: 'utf-8'
            {
                "fulfillmentText": response,
                "payload": {
                    "telegram": {
                        "text": response,
                        "parse_mode": "Markdown"
                    }
                }
            }.to_json
        end
end