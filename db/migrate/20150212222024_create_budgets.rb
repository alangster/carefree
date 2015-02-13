class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
    	t.decimal    :starting_total, precision: 12, scale: 2
    	t.decimal    :remaining_total, precision: 12, scale: 2
    	t.references :budgetable, polymorphic: true

      t.timestamps
    end
  end
end
