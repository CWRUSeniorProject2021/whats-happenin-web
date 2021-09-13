class Event < ApplicationRecord

  belongs_to :user, optional: false
  belongs_to :school, optional: true

  has_one_attached :image

  validates :title, presence: true, length: {in: 3..255}
  validates :description, presence: true, length: {in: 0..10000}
  validates :start_date, presence: true
  validates :end_date, presence: true

  validate :end_after_start, unless: -> {start_date < end_date}

private

  def end_after_start
    self.errors.add(:end_date, "End date must be after start date")
  end
end
