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
    invitation_status 1
  end

  factory :champion do
    name "testChamp"
    game
  end

  factory :score do
    value 1
    description "Good"
  end

  factory :champ_rating do
    user
    champion
    score
    comment "i like testing with this stub champ"
  end

  factory :role do
    name "tester"
    description "a classic unit tester"    
  end

  factory :role_rating do
    role
    user
    score
    game
  end

end