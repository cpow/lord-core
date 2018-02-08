class IssueImage < ApplicationRecord
  belongs_to :issue
  do_not_validate_attachment_file_type :image
  has_attached_file :image, styles: { medium: "300x300>", thumb: "100x100>" }
end
