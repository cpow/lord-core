# == Schema Information
#
# Table name: manual_payment_receipts
#
#  id                 :integer          not null, primary key
#  manual_payment_id  :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class ManualPaymentReceipt < ApplicationRecord
  belongs_to :manual_payment
  validates :manual_payment, presence: true

  has_attached_file :image,
    styles: { medium: "300x300>", thumb: "100x100>" }

  validates_attachment_content_type :image, content_type: /\Aimage\/.*\z/
end
