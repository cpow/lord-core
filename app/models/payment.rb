class Payment < ApplicationRecord
  belongs_to :user
  belongs_to :unit, optional: true
end
