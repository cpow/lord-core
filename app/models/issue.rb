class Issue < ApplicationRecord
  ISSUE_CATEGORIES = [
    'Plumbing',
    'Electrical',
    'Water Damage',
    'Physical Damage',
    'Exterior',
    'Property / Landscaping'
  ].freeze

  belongs_to :property
  belongs_to :unit
  belongs_to :reporter, polymorphic: true
  has_many :issue_images

  validates :category, inclusion: { in: ISSUE_CATEGORIES }
end
