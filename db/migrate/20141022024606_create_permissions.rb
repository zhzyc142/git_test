class CreatePermissions < ActiveRecord::Migration
  def change
    create_table :permissions do |t|
      t.string :action
      t.string :subject
      t.string :description
      t.boolean :is_default, default: false
      t.boolean :is_self, default: false

      t.timestamps
    end
  end
end
