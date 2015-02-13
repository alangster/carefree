class CreateConversationMembers < ActiveRecord::Migration
  def change
    create_table :conversation_members, :id => false do |t|
    	t.belongs_to :member 
    	t.belongs_to :conversation 
    	t.datetime   :last_view

      t.timestamps
    end
  end
end
