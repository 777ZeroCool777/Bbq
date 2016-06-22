class AddPincodeToEvents < ActiveRecord::Migration
  def change
    add_column :events, :pincode, :string
  end
end
