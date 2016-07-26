class WelcomeController < ApplicationController
  def index
  	get_variables
  end

 private

 def get_variables
   @posts = Post.news.order(created_at: :desc).last(3)
   @polls = Poll.opened.order(created_at: :desc).last(3)

 end
end
