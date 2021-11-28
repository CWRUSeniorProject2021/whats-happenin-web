class Comment < ApplicationRecord

    belongs_to :event, optional: false
    belongs_to :user, optional: false

    validates :text, presence: true

end
