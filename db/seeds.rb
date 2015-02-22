Role.destroy_all
User.destroy_all

# create the roles for the entire app

hr       = Role.create!(name: 'HR')
manager  = Role.create!(name: 'Manager')
buddy    = Role.create!(name: 'Buddy')
new_hire = Role.create!(name: 'New Hire')

# create the first user--the main admin

User.create!(first_name:            'The', 
						 last_name:             'Admin', 
						 email:                 'carefreeliving3@gmail.com',
						 admin:                 true,
						 password:              'password',
						 password_confirmation: 'password')

dentoflex = Company.create!(name: 'Dentoflex')

dento_office = Office.create!(company:        dentoflex,
							                phone:          '847-998-7674',
							                street_address: '743 Waveland Ave',
							                zip_code:       '60061',
							                state_abbr:     'IL',
							                city:           'Vernon Hills',
							                contact_email:  'fourfourvh@sbcglobal.net')

joe = User.create(first_name:            'Joe',
									last_name:             'Bags',
									email:                 'fourfourvh@sbcglobal.net',
									phone:                 '773-202-7485',
									office:                dento_office,
									role:                  hr,
									password:              'password',
									password_confirmation: 'password')

danny = User.create(first_name:           'Danny',
									 last_name:             'Ocean',
									 email:                 'danny.ocean@email.net',
									 phone:                 '773-202-7485',
									 office:                dento_office,
									 role:                  manager,
									 password:              'password',
									 password_confirmation: 'password')

saul = User.create(first_name:            'Saul',
									 last_name:             'Bloom',
									 email:                 'saul.bloom@email.net',
									 phone:                 '773-202-7485',
									 office:                dento_office,
									 role:                  manager,
									 password:              'password',
									 password_confirmation: 'password')

rusty = User.create(first_name:            'Rusty',
									  last_name:             'Ryan',
									  email:                 'rusty.ryan@email.net',
									  phone:                 '773-202-7485',
									  office:                dento_office,
									  role:                  hr,
									  password:              'password',
									  password_confirmation: 'password')

linus = User.create(first_name:            'Linus',
									  last_name:             'Caldwell',
									  email:                 'linus.caldwell@email.net',
									  phone:                 '773-202-7485',
									  office:                dento_office,
									  role:                  new_hire,
									  password:              'password',
									  password_confirmation: 'password')

livingston = User.create(first_name:            'Livingston',
									       last_name:             'Dell',
									       email:                 'livingston.dell@email.net',
									       phone:                 '773-202-7485',
									       office:                dento_office,
									       role:                  new_hire,
									       password:              'password',
									       password_confirmation: 'password')

basher = User.create(first_name:            'Basher',
									   last_name:             'Tarr',
									   email:                 'basher.tarr@email.net',
									   phone:                 '773-202-7485',
									   office:                dento_office,
									   role:                  new_hire,
									   password:              'password',
									   password_confirmation: 'password')

frank = User.create(first_name:            'Frank',
									  last_name:             'Catton',
									  email:                 'frank.catton@email.net',
									  phone:                 '773-202-7485',
									  office:                dento_office,
									  role:                  new_hire,
									  password:              'password',
									  password_confirmation: 'password')
 
virgil = User.create(first_name:            'Virgil',
									   last_name:             'Malloy',
									   email:                 'virgil.malloy@email.net',
									   phone:                 '773-202-7485',
									   office:                dento_office,
									   role:                  new_hire,
									   password:              'password',
									   password_confirmation: 'password')
   
turk = User.create(first_name:            'Turk',
									 last_name:             'Malloy',
									 email:                 'turk.malloy@email.net',
									 phone:                 '773-202-7485',
									 office:                dento_office,
									 role:                  new_hire,
									 password:              'password',
									 password_confirmation: 'password')

eleven = Cohort.create(name:   "Ocean's Eleven",
											 office: dento_office)

eleven.members << [*joe, danny, saul, rusty, linus, livingston, basher, frank, virgil, turk]
