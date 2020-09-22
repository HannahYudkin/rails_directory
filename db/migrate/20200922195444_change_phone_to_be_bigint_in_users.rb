class ChangePhoneToBeBigintInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :phone, :bigint
  end
end
