class TweetsController < ApplicationController
  
  get '/tweets' do 
    if Helpers.logged_in?(session)
      @tweets= Tweet.all 
      erb :"tweets/tweets"
    else 
      redirect '/login'
    end 
  end 
  #above loads all of the tweets-via tweets erb, only IF, they are logged in \. Check Tweets file 
  
  
  get '/tweets/new' do 
    #load the create tweet form 
    if Helpers.logged_in?(session)
      erb :"tweets/new" 
    else 
      redirect '/login'
    end 
  end 
  
  post '/tweets' do 
    #processes the form submission
    user = Helpers.current_user(session)
    if params[:content].empty?
      redirect to '/tweets/new'
    else
      tweet = Tweet.create(content: params[:content], id: :id)
      redirect to '/tweets'
    end 
  end
 
  get '/tweeets/:id' do 
     if !Helpers.is_logged_in?(session)
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
    #if not logged in, direct to login- otherwise find tweet by id 
  end 
  
  # get '/tweets/:id/edit' do
  #   redirect to '/login' unless Helpers.is_logged_in?(session)

  #   @tweet = Tweet.find(params[:id])
  #   if @tweet.user == Helpers.current_user(session)
  #       erb :'/tweets/edit_tweet'
  #   else
  #     redirect to '/login'
  #   end
  # end 
  
end
