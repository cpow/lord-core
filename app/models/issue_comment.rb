class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :commentable, polymorphic: true
  has_many :events, as: :eventable
end
