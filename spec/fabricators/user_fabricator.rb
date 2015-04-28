Fabricator(:user) do
  username { Faker::Internet.user_name }
  phone_number { Faker::PhoneNumber.phone_number }
  password { Faker::Internet.password }
end
