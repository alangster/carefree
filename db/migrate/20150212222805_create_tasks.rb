class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
    	t.text       :description
    	t.string     :picture
    	t.string     :file
    	t.belongs_to :checklist
    	t.belongs_to :assigner

      t.timestamps
    end
  end
end
