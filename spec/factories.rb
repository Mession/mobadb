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

  factory :champion do
    name "testChamp"
    game
  end

  factory :score do
    value 1
    description "i pwn at testing with this stub"
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