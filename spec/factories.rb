FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :game do
    name "testGame"
  end

  factory :team do
    name "testTeam"
    year "2004"
    location "testland"
    game
    max_members 3
  end

  factory :membership do
    user
    team
    team_leader false
  end

end