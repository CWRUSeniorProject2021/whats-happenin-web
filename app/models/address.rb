class Address < ApplicationRecord
  geocoded_by :to_string
  after_validation :geocode

  belongs_to :addressable, :polymorphic => true

  validate :valid_country_code, unless: -> {self.country_code.in?(COUNTRY_CODES.keys)}

  COUNTRY_CODES = {
    "US" => "United States",
  }.freeze

  STATE_CODES = {
    "US" => {
      "IL" => "Illinois",
    }.freeze
  }.freeze

  ##
  # Convert the address to comma separated string form.
  def to_string
    [self.street1, self.street2, self.city, self.state_code, self.country_code].compact.join(", ")
  end

  private

  ##
  # The address' country code needs to be in the list of valid country codes.
  def valid_country_code
    self.errors.add(:country_code, "is not available for use.")
  end
end
