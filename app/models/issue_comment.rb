# == Schema Information
#
# Table name: issue_comments
#
#  id               :bigint(8)        not null, primary key
#  issue_id         :bigint(8)
#  commentable_type :string
#  commentable_id   :bigint(8)
#  body             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class IssueComment < ApplicationRecord
  belongs_to :issue
  belongs_to :commentable, polymorphic: true
  has_many :events, as: :eventable
end
