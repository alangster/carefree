class AddContactEmailToOffices < ActiveRecord::Migration
  def change
    add_column :offices, :contact_email, :string
  end
end
