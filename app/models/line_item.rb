class LineItem < ApplicationRecord
  belongs_to :itemable, polymorphic: true
  belongs_to :company
end
