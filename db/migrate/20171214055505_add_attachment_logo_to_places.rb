class AddAttachmentLogoToPlaces < ActiveRecord::Migration[5.1]
  def self.up
    change_table :places do |t|
      t.attachment :logo
    end
  end

  def self.down
    remove_attachment :places, :logo
  end
end
