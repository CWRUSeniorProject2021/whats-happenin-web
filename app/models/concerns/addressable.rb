##
# Allows objects to have addresses
module Addressable
  extend ActiveSupport::Concern

  included do
    has_many :addresses, :as => :addressable, dependent: :destroy
  end
end
