require_relative '../../spec_helper'

describe TranslateModule::HelpService do
    describe '#call' do
        it 'Response have the main commands' do
            response = TranslateModule::HelpService.call()
            expect(response).to match('help')
            expect(response).to match('Como se fala "palavras" em linguagemA')
            expect(response).to match('Traduza "palavras" de linguagemA para linguagemB')
        end
    end
end