class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
    	t.belongs_to :company
    	t.string     :phone
    	t.string     :street_address
    	t.string     :zip_code
    	t.string     :state_abbr
    	t.string     :join_token

      t.timestamps
    end
  end
end
