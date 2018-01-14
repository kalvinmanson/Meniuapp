class AddAttachmentPictureToPlates < ActiveRecord::Migration[5.1]
  def self.up
    change_table :plates do |t|
      t.attachment :picture
    end
  end

  def self.down
    remove_attachment :plates, :picture
  end
end
