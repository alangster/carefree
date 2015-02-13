class CreateCohortMembers < ActiveRecord::Migration
  def change
    create_table :cohort_members, :id => false do |t|
    	t.belongs_to :user
    	t.belongs_to :cohort

      t.timestamps
    end
  end
end
