# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

game = Game.create name:"LoL", character_called:"Champion"
user = User.create username:"test", password:"test", password_confirmation:"test"
user2 = User.create username:"asd", password:"asd", password_confirmation:"asd"
team = Team.create name:"testTeam", year:2014, location:"testland", game: game
team2 = Team.create name:"asdTeam", year:2014, location:"asdland", game: game
Membership.create user:user, team:team, team_leader: true, invitation_status: 1
Membership.create user:user2, team:team, team_leader: false, invitation_status: 1
Membership.create user:user2, team:team2, team_leader: true, invitation_status: 1

champ = Champion.create name:"TestChamp", game:game
score = Score.create value:1, description:"very test, such wow"
ChampRating.create user:user, champion:champ, score:score, comment:"ahmazing"