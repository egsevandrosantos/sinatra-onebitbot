module TranslateModule
    class HelpService
        def self.call
            response = "*Meus comandos*\n\n"
            response += "help\n"
            response += "`Lista de comandos que eu conheço`\n\n"
            response += "Como se fala \"palavras\" em linguagemA\n"
            response += "`Traduz as palavras para a linguagemA`\n\n"
            response += "Traduza \"palavras\" de linguagemA para linguagemB\n"
            response += "`Traduz as palavras de linguagemA para linguagemB`\n\n"
            response
        end
    end
end