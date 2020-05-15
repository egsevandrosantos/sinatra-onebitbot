module FaqModule
    class RemoveService
        def initialize(params)
            @id = params[:id]
        end

        def call
            faq = Faq.where(id: @id).first
            return 'Questão inválida, verifique o Id' if faq == nil

            Faq.transaction do
                # Deleta as tags associadas que não estejam associadas a outros faqs
                faq.hashtags.each do |h|
                    if h.faqs.count <= 1
                        h.delete
                    end
                end
                faq.delete
                'Deletado com sucesso'
            end
        end
    end
end