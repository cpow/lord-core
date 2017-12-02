class Lease < ApplicationRecord
  belongs_to :unit
  has_many :payments
end
