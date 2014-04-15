# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

game = Game.create name:"LoL"
user = User.create username:"test", password:"test", password_confirmation:"test"
team = Team.create name:"testTeam", year:1234, location:"testland", game: game
Membership.create user:user, team:team

champ = Champion.create name:"TestChamp", game:game
score = Score.create value:1, description:"very test, such wow"
ChampRating.create user:user, champion:champ, score:score, comment:"ahmazing"