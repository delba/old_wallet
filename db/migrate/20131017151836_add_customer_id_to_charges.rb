class AddCustomerIdToCharges < ActiveRecord::Migration
  def change
    add_reference :charges, :customer, index: true
  end
end
