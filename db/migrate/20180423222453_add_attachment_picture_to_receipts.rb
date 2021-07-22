class AddAttachmentPictureToReceipts < ActiveRecord::Migration[5.1]
  def self.up
    change_table :reciepts do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :reciepts, :picture
  end
end
