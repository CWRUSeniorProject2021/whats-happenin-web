class Event < ApplicationRecord

  enum visibility: { school_vis: 0, public_vis: 1 }
  enum rsvp_type: { open: 0, rsvp: 1}

  before_validation :set_infinite_attendee_limit, if: -> {self.attendee_limit.blank?}

  belongs_to :user, optional: false
  belongs_to :school, optional: true

  has_one_attached :image
  has_one :address, :as => :addressable, :dependent => :destroy

  has_many :event_attendees, inverse_of: :event, dependent: :destroy
  has_many :attendees, through: :event_attendees, source: :user
  has_many :comments, inverse_of: :event, dependent: :destroy

  accepts_nested_attributes_for :address

  validates :title, presence: true, :length => { in: 3..255 }
  validates :description, presence: true, :length => { in: 0..10000 }
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :address, presence: true

  validate :end_after_start, if: -> {self.start_date > self.end_date}

private

  ##
  # Validate that the end date is after the start date.
  def end_after_start
    self.errors.add(:end_date, "must be after start date.")
  end

  ##
  # Sets the attendee limit to the infinity value if there is no limit set.
  def set_infinite_attendee_limit
    self.attendee_limit = -1
  end
end
