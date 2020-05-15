require 'pg_search'

class Faq < ActiveRecord::Base
    include PgSearch
    
    has_many :faq_hashtags
    has_many :hashtags, through: :faq_hashtags

    validates :question, presence: true
    validates :answer, presence: true

    pg_search_scope :search, against: [:question, :answer]
end