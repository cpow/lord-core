# == Schema Information
#
# Table name: issue_comments
#
#  id               :integer          not null, primary key
#  issue_id         :integer
#  commentable_type :string
#  commentable_id   :integer
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :commentable, polymorphic: true
  has_many :events, as: :eventable
end
