class School < ApplicationRecord
  has_many :domains, inverse_of: :school
  has_many :users, inverse_of: :school

  validates :name, presence: true
end
