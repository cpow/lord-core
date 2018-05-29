# == Schema Information
#
# Table name: issues
#
#  id            :integer          not null, primary key
#  property_id   :integer
#  unit_id       :integer
#  reporter_type :string
#  reporter_id   :integer
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

  searchkick _all: false, default_fields: [:name]

  def search_data
    {
      category: category,
      reporter_name: reporter.name,
      unit_name: unit.name,
      status: status,
      created_at: created_at
    }
  end
end
