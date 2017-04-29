class RenameDateOfBirthToUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :data_of_birth, :date_of_birth
  end
end
