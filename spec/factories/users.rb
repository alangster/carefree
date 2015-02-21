FactoryGirl.define do
  factory :user do
    first_name            'Joe'
    last_name             'Bags'
    sequence(:email)      {|n| "user#{n}@factory.com"}
    office_id             1
    password              'boom'
    password_confirmation 'boom'
    admin                 false
  end

  factory :admin, class:  'User' do 
  	first_name            'The'
    last_name             'Admin'
    sequence(:email)      {|n| "admin#{n}@carefree.com"}
    password              'boom'
    password_confirmation 'boom'
    admin                  true
  end

  factory :new_user, class: 'User' do 
    first_name            'Joe'
    last_name             'Bags'
    sequence(:email)      {|n| "user#{n}@factory.com"}
    phone                 '8479824300'
    password              'boom'
    password_confirmation 'boom'
  end

  factory :blank_user, class: 'User' do 
    sequence(:email)      {|n| "user#{n}@factory.com"}
  end

end
