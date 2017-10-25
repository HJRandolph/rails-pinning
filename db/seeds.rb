
9.times do |n|
  name = Faker::Name.first_name
  i = name[0]
  last = Faker::Name.last_name
  User.create!(
    first_name: name,
    last_name: last,
    email: i + last + "#{n+1}@example.com",
    password: "password"
    )

end