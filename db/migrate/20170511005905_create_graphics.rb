class CreateGraphics < ActiveRecord::Migration[5.0]
  def change
    create_table :graphics do |t|
      t.integer :comment_id
      t.string :avatar

      t.timestamps
    end
  end
end
