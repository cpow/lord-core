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

require 'rails_helper'

RSpec.describe IssueComment, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
