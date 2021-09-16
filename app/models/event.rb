class Event < ApplicationRecord

  enum visibility: {school_vis: 0, public_vis: 1}

<<<<<<< a30d3bfcfe38c37b4e81f1fe3ebaaede7bfd319d
  before_validation :set_infinite_attendee_limit, if: -> {self.attendee_limit.blank?}
=======
  acts_as_addressable :event
>>>>>>> Added addressable gem

  belongs_to :user, optional: false
  belongs_to :school, optional: true

  has_one_attached :image

  has_many :event_attendees, inverse_of: :event, dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :user

  validates :title, presence: true, length: {in: 3..255}
  validates :description, presence: true, length: {in: 0..10000}
  validates :start_date, presence: true
  validates :end_date, presence: true
<<<<<<< a30d3bfcfe38c37b4e81f1fe3ebaaede7bfd319d
  validates :attendee_limit, numericality: {less_than_or_equal_to: 2000000000}
=======
  #validates :event_address, presence: true
>>>>>>> Added addressable gem

  validate :end_after_start, if: -> {self.start_date > self.end_date}

private

  def end_after_start
    self.errors.add(:end_date, "End date must be after start date")
  end

  def set_infinite_attendee_limit
    self.attendee_limit = -1
  end
end
