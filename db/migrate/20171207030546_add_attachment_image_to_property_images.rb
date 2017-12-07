class AddAttachmentImageToPropertyImages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :property_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :property_images, :image
  end
end
