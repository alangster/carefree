FactoryGirl.define do
  factory :company do
	  name   'The Company'
    locked false
  end

  factory :blank_company, class: 'Company' do
  	name '' 
  end

end
