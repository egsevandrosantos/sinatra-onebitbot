require_relative '../../spec_helper.rb'

describe TranslateModule::TranslateService do
    describe '#call' do
        context 'without sentence for translate' do
            it 'will receive a error' do
                @translateService = TranslateModule::TranslateService.new({'langs' => ['en']})
                response = @translateService.call()
                expect(response).to match('Sentença a ser traduzida obrigatória')
            end
        end

        context 'without langs for translate' do
            it 'will receive a error' do
                @translateService = TranslateModule::TranslateService.new({'sentence' => 'oi'})
                response = @translateService.call()
                expect(response).to match('Linguagem destino obrigatória')
            end
        end

        context 'with valid params' do
            it 'receive translated message with one lang' do
                @translateService = TranslateModule::TranslateService.new({'sentence' => 'olá', 'langs' => ['en']})
                response = @translateService.call()
                expect(response).to match('(Português) olá | (Inglês) hello')
            end

            it 'receive translated message with two langs' do
                @translateService = TranslateModule::TranslateService.new({'sentence' => 'oi', 'langs' => ['pt', 'en']})
                response = @translateService.call()
                expect(response).to match('(Português) oi | (Inglês) hi')
            end
        end
    end
end