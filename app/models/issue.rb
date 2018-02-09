class Issue < ApplicationRecord
  ACK = 'acknowledged'.freeze
  IN_PROGRESS = 'in progress'.freeze
  COMPLETED = 'completed'.freeze
  CREATED = 'created'.freeze

  ISSUE_STATUSES = [
    ACK,
    CREATED,
    IN_PROGRESS,
    COMPLETED
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
