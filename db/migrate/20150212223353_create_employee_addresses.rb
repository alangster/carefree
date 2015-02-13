class CreateEmployeeAddresses < ActiveRecord::Migration
  def change
    create_table :employee_addresses do |t|
    	t.belongs_to :office
    	t.string     :latitude
    	t.string     :longitude
    	t.string     :street_address
    	t.string     :zip_code
    	t.string     :state_abbr

      t.timestamps
    end
  end
end
