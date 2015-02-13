class AddLockedToCompanies < ActiveRecord::Migration
  def change
    add_column :companies, :locked, :boolean, default: false
  end
end
