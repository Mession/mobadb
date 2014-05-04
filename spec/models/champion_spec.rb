require 'spec_helper'

describe Champion do

  describe "method" do
    let(:game){ FactoryGirl.create(:game, name: "League of Legends") }
    let(:game2){ FactoryGirl.create(:game, name:"Dota 2") }

    let(:champion){ FactoryGirl.create(:champion, name: "test", game: game) }
    let(:hero){ FactoryGirl.create(:champion, name: "test2", game: game2) }

    describe "wiki_link" do
      it "returns LoL wiki link when character is a LoL champion" do
        link = "http://leagueoflegends.wikia.com/wiki/test"
        
        expect(champion.wiki_link).to eq(link)
      end

      it "returns Dota2 wiki link when character is a Dota2 hero" do
        link = "http://dota2.gamepedia.com/test2"

        expect(hero.wiki_link).to eq(link)
      end


    end
  end
end