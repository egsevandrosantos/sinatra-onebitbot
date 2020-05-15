class Hashtag < ActiveRecord::Base
    has_many :faq_hashtags
    has_many :faqs, through: :faq_hashtags

    validates :name, presence: true
end