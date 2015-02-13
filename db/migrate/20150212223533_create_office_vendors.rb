class CreateOfficeVendors < ActiveRecord::Migration
  def change
    create_table :office_vendors, :id => false do |t|
    	t.belongs_to :office
    	t.belongs_to :vendor

      t.timestamps
    end
  end
end
