class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
	    t.text       :text
    	t.string     :file
    	t.belongs_to :conversation
    	t.belongs_to :sender

      t.timestamps
    end
  end
end
