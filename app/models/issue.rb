class Issue < ApplicationRecord
  ISSUE_STATUSES = [
    'created',
    'acknowledged',
    'in progress',
    'completed'
  ].freeze

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
  has_many :issue_comments

  validates :category, inclusion: { in: ISSUE_CATEGORIES }
  validates :status, inclusion: { in: ISSUE_STATUSES }
end
