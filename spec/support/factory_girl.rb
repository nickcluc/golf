require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    first_name "Nick"
    last_name "Clucas"
    password 'password'
    password_confirmation 'password'
  end

  factory :course do
    name "The Meadow at Peabody"
    street_address "80 Granite Street"
    city "Peabody"
    state "MA"
    zip_code "01960"

    after(:build) { |course| course.class.skip_callback(:create, :after, :geocode) }
    user
  end

  factory :tee do
    name "White"
    color "White"
    slope 124
    rating 68.7
    yardage 5795

    course
  end

  factory :round do
    round_date Date.today
    tee_time "9:26am"

    user
    course
  end

  factory :player_round do
    hole_count 18
    score 80

    round
    tee
  end

end
