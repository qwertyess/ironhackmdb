require 'rubygems'
require 'active_record'
require 'erb'
require 'imdb'
require 'sinatra'
# require 'sinatra/reloader'

set :port, 3001
set :bind, "0.0.0.0"

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: 'ironhackmdb.sqlite'
)

class TVShow < ActiveRecord::Base
  # we have name, own_rating and own_comments available

  validates_presence_of :name, :own_comments, :own_rating
  validates_inclusion_of :own_rating, :in => 0..10
  validates_size_of :own_comments, :in => 100..1000
  validates_uniqueness_of :name

  def imdb_rating
  	@imdb_movie_object = Imdb::Search.new(name).movies.first
  	@imdb_movie_object.rating
  end

  def imdb_number_of_seasons
  	@imdb_movie_object.seasons.size
  end

  def imdb_link
  	@imdb_movie_object.title
  end

  def imbdb_picture
  	@imdb_movie_object.poster
  end
end

get '/' do
	@shows = TVShow.all
	erb :index
end

get '/new_show' do
	paramsp[]
	tv = TVShow.new
	tv.name = params[:name]
	tv.own_rating = params[:own_ratng]
	tv.own_comments = params [:own_comments]
	if tv.save == true
		redirect to('/')
	else
		@errors = tv.errors
		erb :error_page
	end
end


# describe TVShow do
# 		before do
# 			@friends = TVShow.new
# 			@friends.name = "Chandler"
# 		end

# 		it "should have the presence of a name" do
# 			@friends.name  = nil
# 			@friends.valid?.should be_falsy
# 		end

# 		it "should have the presence of comments" do
# 			@friends.own_comments = nil
# 			@friends.valid?.should be_falsy
# 		end

# 		it "should have own rating between 0 and 10 including" do
# 			@friends.own_comments = 11
# 			@friends.valid?.should be_falsy
# 		end

# 		it "should have a comment section with 100 chrs to 1000 chrs" do
# 			@friends.own_comments = 99
# 			@friends.valid?.should be_falsy
# 		end

# 		context "when there is an existing TV show with a name" do
# 			before do
# 				@friends2 = TVShow.new
# 				@friends2.name = "Chandler"
# 		# create a TV show with a specific name
# 		end
	
# 		it "should not allow another TV show with that name" do
# 			# check that the second TV show is not valid
# 			@friends2.valid?.should be_falsy
# 		end
		
# 		after do
# 			# remove the TV show we created with that name
# 			@friends2.destroy
# 		end
# 	end
# end