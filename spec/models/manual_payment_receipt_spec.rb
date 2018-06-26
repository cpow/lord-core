# == Schema Information
#
# Table name: manual_payment_receipts
#
#  id                 :bigint(8)        not null, primary key
#  manual_payment_id  :bigint(8)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

require 'rails_helper'

RSpec.describe ManualPaymentReceipt, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
