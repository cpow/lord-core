# == Schema Information
#
# Table name: property_images
#
#  id                 :bigint(8)        not null, primary key
#  property_id        :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class PropertyImage < ApplicationRecord
  has_attached_file :image, styles: { large: "700x700>",
                                      medium: "300x300>",
                                      thumb: "100x100>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/

  belongs_to :property
end
