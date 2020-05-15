class HelpService
    def self.call
        response = "*Meus comandos* \n\n"
        response += "help\n"
        response += "`Lista de comandos que eu conheço`\n\n"
        response += "Adicione ao Faq\n"
        response += "`Adiciona uma nova questão ao Faq`\n\n"
        response += "Remova Id\n"
        response += "`Remove uma questão baseado no número identificador (Id) passado`\n\n"
        response += "O que você sabe sobre ?\n"
        response += "`Pesquisa pela palavra informada (?) na lista de perguntas e respostas`\n\n"
        response += "Pesquise a hashtag ?\n"
        response += "`Lista as perguntas e respostas com a hashtag informada (?)`\n\n"
        response += "Perguntas e Respostas\n"
        response += "`Mostra a lista de perguntas e respostas`\n\n"
        response
    end
end