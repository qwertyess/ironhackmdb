require 'rubygems'
require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb.sqlite'
)

class TVShow < ActiveRecord::Base
  # we have name, own_rating and own_comments available

  validates_presence_of :name, :own_comments, :own_rating
  validates_inclusion_of :own_rating, :in => 0..10
  validates_inclusion_of :own_comments, :in => 100..1000

end


describe TVShow do
		before do
			@friends = TVShow.new
			@friends.name = "Chandler"
		end

		it "should have the presence of a name" do
			@friends.name  = nil
			@friends.valid?.should be_falsy
		end

		it "should have the presence of comments" do
			@friends.own_comments = nil
			@friends.valid?.should be_falsy
		end

		it "should have own rating between 0 and 10 including" do
			@friends.own_comments = 11
			@friends.valid?.should be_falsy
		end

		it "should have a comment section with 100 chrs to 1000 chrs" do
			@friends.own_comments = 99
			@friends.valid?.should be_falsy
		end
end