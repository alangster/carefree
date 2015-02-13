class CreateVendors < ActiveRecord::Migration
  def change
    create_table :vendors do |t|
    	t.string     :name
    	t.string     :phone
    	t.string     :email
    	t.string     :street_address
    	t.string     :zip_code
    	t.string     :state_abbr
    	t.belongs_to :vendor_cagory

      t.timestamps
    end
  end
end
