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

require 'rails_helper'

RSpec.describe PropertyImage, type: :model do
end
