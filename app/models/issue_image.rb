# == Schema Information
#
# Table name: issue_images
#
#  id                 :integer          not null, primary key
#  issue_id           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class IssueImage < ApplicationRecord
  belongs_to :issue
  do_not_validate_attachment_file_type :image
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
end
