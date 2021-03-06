class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string     :first_name
    	t.string     :last_name
    	t.string     :email
    	t.string     :phone
    	t.string     :photo
    	t.belongs_to :office
    	t.belongs_to :role
    	t.string 		 :password_reset_token
    	t.datetime   :password_reset_sent_at

      t.timestamps
    end
  end
end
