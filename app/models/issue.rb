# == Schema Information
#
# Table name: issues
#
#  id            :bigint(8)        not null, primary key
#  property_id   :bigint(8)
#  unit_id       :bigint(8)
#  reporter_type :string
#  reporter_id   :bigint(8)
#  description   :text
#  category      :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  status        :string           default("created")
#

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
  has_many :expenses, as: :expenseable

  validates :category, inclusion: { in: ISSUE_CATEGORIES }
  validates :status, inclusion: { in: ISSUE_STATUSES }

  searchkick _all: false

  def search_data
    {
      property_id: property.id,
      category: category,
      reporter_name: reporter.name,
      unit_name: unit.name,
      status: status,
      created_at: created_at
    }
  end
end
