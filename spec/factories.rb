FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end
  factory :user2, class: User do
    username "Arto"
    password "Foobar2"
    password_confirmation "Foobar2"
  end

  factory :team do
    name "testTeam"
    year "2000"
    location "testland"
    game
  end

  factory :game do
    name "testGame"
  end

  factory :membership do
    user
    team
    team_leader true
  end

  factory :membership2, class: Membership do
    user :user2
    team
    team_leader false
  end



end