class AddAttachmentCoverToPlaces < ActiveRecord::Migration[5.1]
  def self.up
    change_table :places do |t|
      t.attachment :cover
    end
  end

  def self.down
    remove_attachment :places, :cover
  end
end
