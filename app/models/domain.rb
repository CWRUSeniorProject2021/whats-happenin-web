class Domain < ApplicationRecord
  belongs_to :school, optional: false

  validates :school, presence: true
  validates :domain, presence: true, uniqueness: true
end
