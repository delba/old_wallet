class CreateCharges < ActiveRecord::Migration
  def change
    create_table :charges do |t|
      t.references :user, index: true
      t.integer :amount
      t.string :currency
      t.string :stripe_id

      t.timestamps
    end
  end
end
