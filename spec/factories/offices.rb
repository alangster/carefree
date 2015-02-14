FactoryGirl.define do
  factory :office do
    company_id     1
    phone          "1234567890"
    street_address "50 Street St"
    zip_code       "60061"
    state_abbr     "IL"
    contact_email  "hr@company.com"
  end
end
