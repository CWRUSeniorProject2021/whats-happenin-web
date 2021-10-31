class Address < ApplicationRecord
  geocoded_by :to_string
  after_validation :geocode

  before_validation :set_default_country_code, if: -> {self.country_code.blank?}
  before_validation :format_country_code, if: -> {self.country_code.present?}
  before_validation :format_state_code, if: ->{self.state_code.present?}

  belongs_to :addressable, :polymorphic => true

  validates_presence_of :street1, :city, :state_code, :country_code, :postal_code

  #validate :valid_country_code, unless: -> {self.country_code.in?(COUNTRY_CODES.keys)}
  validate :valid_state_and_country

  UNITED_STATES_CODE = "US"

  COUNTRY_CODES = {
    "US" => "United States",
  }.freeze

  STATE_CODES = {
    "US" => {
      "AL" => "Alabama",
      "AK" => "Alaska",
      "AZ" => "Arizona",
      "AR" => "Arkansas",
      "CA" => "California",
      "CZ" => "Canal Zone",
      "CO" => "Colorado",
      "CT" => "Connecticut",
      "DE" => "Delaware",
      "DC" => "District of Columbia",
      "FL" => "Florida",
      "GA" => "Georgia",
      "GU" => "Guam",
      "HI" => "Hawaii",
      "ID" => "Idaho",
      "IL" => "Illinois",
      "IN" => "Indiana",
      "IA" => "Iowa",
      "KS" => "Kansas",
      "KY" => "Kentucky",
      "LA" => "Louisiana",
      "ME" => "Maine",
      "MD" => "Maryland",
      "MA" => "Massachusetts",
      "MI" => "Michigan",
      "MN" => "Minnesota",
      "MO" => "Missouri",
      "MT" => "Montana",
      "NE" => "Nebraska",
      "NV" => "Nevada",
      "NH" => "New Hampshire",
      "NJ" => "New Jersey",
      "NM" => "New Mexico",
      "NY" => "New York",
      "NC" => "North Carolina",
      "ND" => "North Dakota",
      "OH" => "Ohio",
      "OK" => "Oklahoma",
      "OR" => "Oregon",
      "PA" => "Pennsylvania",
      "PR" => "Puerto Rico",
      "RI" => "Rhode Island",
      "SC" => "South Carolina",
      "SD" => "South Dakota",
      "TN" => "Tennessee",
      "TX" => "Texas",
      "UT" => "Utah",
      "VT" => "Vermont",
      "VI" => "Virgin Islands",
      "VA" => "Virginia",
      "WA" => "Washington",
      "WV" => "West Virginia",
      "WI" => "Wisconsin",
      "WY" => "Wyoming"
    }.freeze
  }.freeze

  ##
  # Convert the address to comma separated string form.
  def to_string
    [self.street1, self.street2, self.city, self.state_code, self.country_code].compact.join(", ")
  end

  ##
  # Gets the country name from the country code.
  def country_name
    COUNTRY_CODES[self.country_code]
  end

  ##
  # Gets the state name from the state code.
  def state_name
    STATE_CODES[self.country_code][self.state_code]
  end

  private

  ##
  # The address' country code needs to be in the list of valid country codes.
  def valid_country_code
    self.errors.add(:country_code, "is not available for use.")
  end

  ##
  # Set the default country code to be united states if it is not specified.
  def set_default_country_code
    self.country_code = UNITED_STATES_CODE
  end

  ##
  # Sets country code to capitals.
  def format_country_code
    self.country_code = self.country_code.upcase
  end

  ##
  # Sets state code to captials.
  def format_state_code
    self.state_code = self.state_code.upcase
  end

  ##
  # Ensures that the country and state codes are listed in the valid state and countries hash.
  def valid_state_and_country
    if self.country_code.in?(COUNTRY_CODES.keys)
      unless self.state_code.in?(STATE_CODES[self.country_code])
        self.errors.add(:state_code, "is not a valid state in this country.")
      end
    else
      self.errors.add(:country_code, "is not supported in this country.")
    end
  end
end
