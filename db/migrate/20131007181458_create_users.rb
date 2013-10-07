class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :stripe_token
      t.string :stripe_user_id
      t.string :stripe_publishable_key

      t.timestamps
    end
    add_index :users, :stripe_user_id, unique: true
  end
end
