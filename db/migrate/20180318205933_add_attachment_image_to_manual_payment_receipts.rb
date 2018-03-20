class AddAttachmentImageToManualPaymentReceipts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :manual_payment_receipts do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :manual_payment_receipts, :image
  end
end
