require 'rest-client'
require 'json'
require 'uri'

module TranslateModule
    class TranslateService
        def initialize(params)
            @langs = params['langs']
            @sentence = params['sentence']
        end

        def call
            begin
                result = get_value
                return result if result.class == String
                langs = {
                    'az' => 'Azerbaijano', 'be' => 'Bielo-Russo', 'bg' => 'Búlgaro', 'ca' => 'Catalão', 'cs' => 'Tcheco', 
                    'da' => 'Dinamarquês', 'de' => 'Alemão', 'el' => 'Grego', 'en' => 'Inglês', 'es' => 'Espanhol', 
                    'et' => 'Estoniano', 'fi' => 'Filandês', 'fr' => 'Francês', 'hr' => 'Croata', 'hu' => 'Húngaro', 
                    'hy' => 'Armênio', 'it' => 'Italiano', 'lt' => 'Lituano', 'lv' => 'Letão', 'mk' => 'Macedônio', 
                    'nl' => 'Holandês', 'no' => 'Norueguês', 'pl' => 'Polonês', 'pt' => 'Português', 'ro' => 'Romeno', 
                    'ru' => 'Russo', 'sk' => 'Eslovaco', 'sl' => 'Esloveno', 'sq' => 'Albanês', 'sr' => 'Sérvio',
                    'sv' => 'Sueco', 'tr' => 'Turco', 'uk' => 'Ucraniano'
                }
                "(#{langs[result[:de]]}) #{@sentence} | (#{langs[result[:para]]}) #{result[:text]}"
            rescue RestClient::ExceptionWithResponse => exception
                exception.response
            end
        end

        private
            def get_value
                return 'Sentença a ser traduzida obrigatória' if @sentence == nil
                return 'Linguagem destino obrigatória' if @langs == nil || @langs.count == 0
                url = Secret['yandex_api_url']
                key = Secret['yandex_api_key']
                url += "?key=#{key}&text=#{@sentence}"
                if @langs.count == 1
                    url += "&lang=#{@langs[0]}"
                else
                    url += "&lang=#{@langs[0]}-#{@langs[1]}"
                end
                begin
                    uri = URI.parse(url)
                rescue URI::InvalidURIError
                    uri = URI.parse(URI.escape(url))
                end
                request = RestClient.get(uri.to_s)
                result = JSON.parse(request.body)
                langs = result['lang'].split('-')
                {de: langs[0], para: langs[1], text: result['text'][0]}
            end
    end
end