Role.destroy_all
User.destroy_all

# create the roles for the entire app

Role.create!(name: 'HR')
Role.create!(name: 'Manager')
Role.create!(name: 'Buddy')
Role.create!(name: 'New Hire')

# create the first user--the main admin

User.create!(first_name:            'The', 
						 last_name:             'Admin', 
						 email:                 'carefreeliving3@gmail.com',
						 admin:                 true,
						 password:              'password',
						 password_confirmation: 'password')

Company.create!(name: 'Dentoflex')
Office.create!()


