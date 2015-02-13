class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
    	t.string     :name
    	t.string     :join_token
    	t.belongs_to :office

      t.timestamps
    end
  end
end
