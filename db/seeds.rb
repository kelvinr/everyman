10.times { Fabricate(:user); Fabricate(:question); Fabricate(:experience) }

Question.all.each{ |que| 4.times { que.comments.create(content: Faker::Lorem.paragraph, user: User.all.sample) }}
Experience.all.each { |exp| 4.times { exp.comments.create(content: Faker::Lorem.paragraph, user: User.all.sample )}}
