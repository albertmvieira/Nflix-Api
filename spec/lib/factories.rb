require "faker"

require_relative "../models/user_model"

FactoryBot.define do
  factory :user, class: UserModel do
    full_name { "Albert Einstein" }
    email { "albert@einstein.com" }
    password { "einstein123" }

    after(:build) do |user|
      #   puts "apagando o email " + user.email
      Database.new.delete_user(user.email)
    end
  end

  # Utilizando faker para massa ficar dinâmica e ser reaproveitada no cenário de
  factory :registered_user, class: UserModel do
    id { 0 }
    full_name { Faker::Movies::StarWars.character }
    email { Faker::Internet.free_email(name: full_name) }
    password { "darthvader" }

    after(:build) do |user|
      #   puts "apagando o email " + user.email
      Database.new.delete_user(user.email)
      result = ApiUser.save(user.to_hash)
      user.id = result.parsed_response["id"]
    end
  end

  factory :user_wrong_email, class: UserModel do
    full_name { "Albert Einstein" }
    email { "albert#einstein.com" }
    password { "einstein123" }
  end

  factory :empty_name_user, class: UserModel do
    full_name { "" }
    email { "albert@einstein.com" }
    password { "einstein123" }
  end

  factory :empty_email_user, class: UserModel do
    full_name { "Albert Einstein" }
    email { "" }
    password { "einstein123" }
  end

  factory :empty_password_user, class: UserModel do
    full_name { "Albert Einstein" }
    email { "albert@einstein.com" }
    password { "" }
  end
end
