class AddAttachmentImageToIssueImages < ActiveRecord::Migration[5.1]
  def self.up
    change_table :issue_images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :issue_images, :image
  end
end
