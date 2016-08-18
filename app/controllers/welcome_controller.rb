class WelcomeController < ApplicationController
  
  def index
  	@posts = Post.published.news.order(created_at: :desc).last(3)
  	@polls = Poll.opened.order(created_at: :desc).last(3)
  end

end