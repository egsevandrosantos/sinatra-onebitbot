class InterpretService
    def self.call(action, params)
        case action
        when 'list', 'search', 'search_by_hashtag'
            FaqModule::ListService.new(params, action).call()
        when 'create'
            FaqModule::CreateService.new(params).call()
        when 'remove'
            FaqModule::RemoveService.new(params).call()
        when 'help'
            HelpService.call()
        else
            'Não entendi qual o seu desejo :(, ainda estou aprendendo'
        end
    end
end