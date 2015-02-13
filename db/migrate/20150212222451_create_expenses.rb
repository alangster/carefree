class CreateExpenses < ActiveRecord::Migration
  def change
    create_table :expenses do |t|
    	t.text       :description
    	t.decimal    :cost, precision: 12, scale: 2
    	t.belongs_to :budget

      t.timestamps
    end
  end
end
