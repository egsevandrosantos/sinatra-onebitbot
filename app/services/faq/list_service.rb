module FaqModule
    class ListService
        def initialize(params, action)
            @query = params['query']
            @action = action
        end

        def call
            faqs = []
            if @action == 'search'
                faqs = Faq.search(@query)
            elsif @action == 'search_by_hashtag'
                hashtag = Hashtag.find_by(name: @query)
                faqs = hashtag.faqs if hashtag != nil
            else
                faqs = Faq.all
            end

            return 'Nada encontrado' if faqs.count == 0
            response = "*Perguntas e Respostas*\n\n"
            faqs.each do |f|
                response += "*#{f.id}* - "
                response += "*#{f.question}*\n"
                response += "`#{f.answer}` \n"
                f.hashtags.each do |h|
                    response += "_##{h.name}_"
                end
                response += "\n\n"
            end
            response
        end
    end
end