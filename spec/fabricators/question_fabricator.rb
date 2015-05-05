Fabricator(:question) do
  question { Faker::Lorem.words.join(" ") }
  additional_info { Faker::Lorem.paragraph }
  user { Fabricate(:user) }
end
