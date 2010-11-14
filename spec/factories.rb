# By using the symbol ':user', we get Factory Girl to simulate the User model.
Factory.define :user do |user|
  user.last_name              "Test"
  user.first_name             "Test"
  user.email                  "test@example.com"
  user.password               "foobar"
  user.password_confirmation  "foobar"
end
