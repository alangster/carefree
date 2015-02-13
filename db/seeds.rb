# create the roles for the entire app

admin = Role.create!(name: 'Admin')
Role.create!(name: 'HR')
Role.create!(name: 'Manager')
Role.create!(name: 'Buddy')
Role.create!(name: 'New Hire')

# create the first user--the main admin

User.create!(first_name: 'The', 
						 last_name: 'Admin', 
						 email: 'carefreeliving3@gmail.com',
						 role: admin,
						 password: 'password')


