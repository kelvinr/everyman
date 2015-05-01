Fabricator(:experience) do
  title { Faker::Lorem.words.join(" ") }
  body { Faker::Lorem.paragraph(5) }
  user { Fabricate(:user) }
end
