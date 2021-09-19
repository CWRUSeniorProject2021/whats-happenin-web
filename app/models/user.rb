class User < ApplicationRecord
  extend Devise::Models

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable, :trackable
  include DeviseTokenAuth::Concerns::User

  enum access_level: { user: 1, mod: 50, admin: 100 }

  belongs_to :school, optional: true

  has_many :events, inverse_of: :user, dependent: :destroy
  has_many :event_attendees, inverse_of: :user, dependent: :destroy
  has_many :attended_events, through: :event_attendees, source: :event

  before_validation :ensure_email_in_domain, :on => :create

  validates :first_name, presence: true, allow_blank: false
  validates :last_name, presence: true, allow_blank: false
  validates :username, uniqueness: { case_sensitive: false }, presence: true, allow_blank: false, format: { with: /\A[a-zA-Z0-9]+\z/ }
  validate  :school_presence, if: -> {!school.present? && email.present?}
  
  private
    def ensure_email_in_domain
      return unless self.email.present?
      email = self.email
      if email.include? "@"
        email_domain = email.partition('@').last
        domain = Domain.find_by_domain(email_domain)
        return unless domain.present?
        self.school = domain.school
      end
    end

    def school_presence()
      self.errors.add(:school, "domain not recognized")
    end
end
