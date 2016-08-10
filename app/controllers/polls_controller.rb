class PollsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_cache_headers, only: [:voting, :show ]
  before_action :set_poll,          only: [:voting, :show, :edit, :update, :destroy]
  before_action :set_editing_time,  only: [:edit, :show, :index]
  #before_action :count_votes,       only: [:show]

  # GET /polls
  # GET /polls.json
  # List of all polls in app
  def index
    case params[:show_me] = params[:show_me] || 'all'
    when 'all'
      @polls = Poll.all.order(state: :asc, created_at: :desc).page params[:page]
    when 'my'
      @polls = current_user.polls.order(state: :asc, created_at: :desc).page params[:page]
    end
  end
  
  # GET /polls/1
  # GET /polls/1.json
  def show
    if Poll.voted_by_user(@poll, current_user) || @poll.closed?
      @votes = []
      voted_users = []
      @poll.options.each_with_index do |option, index|
        @votes.push(option.votes.size)
        voted_users.push(option.votes.pluck(:user_id))
      end
      case @poll.poll_type
        when 'radio'
          @votes.push(@votes.inject(0){|sum,x| sum + x })
        when 'check_box'
          @votes.push(voted_users.uniq.count)
      end
    end
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    @poll.options.build
  end

  # GET /polls/1/edit
  def edit
    if (DateTime.now.to_i - @poll.created_at.to_i) > @editing_time || !@poll.created?
      respond_to do |format|
        format.html { redirect_to @poll, alert: "Sorry! But you can't edit this poll." }
      end   
    end
  end

  # GET /polls/1/voting
  def voting
    if Poll.voted_by_user(@poll, current_user)
      respond_to do |format|
        format.html { redirect_to @poll, alert: "You've voted for this poll." }
      end
    end  
  end

  # POST /polls
  # POST /polls.json
  def create
    @poll = Poll.new(poll_params)
    @poll.user = current_user
    respond_to do |format|
      if @poll.save #check_poll_datetime && 
        format.html { redirect_to @poll, notice: 'Poll was successfully created.' }
        format.json { render :show, status: :created, location: @poll }
      else
        format.html { render :new }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /polls/1
  # PATCH/PUT /polls/1.json
  def update
    respond_to do |format|
      if @poll.update(poll_params)
        format.html { redirect_to @poll, notice: 'Poll was successfully updated.' }
        format.json { render :show, status: :ok, location: @poll }
      else
        format.html { render :edit }
        format.json { render json: @poll.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /polls/1
  # DELETE /polls/1.json
  def destroy
    @poll.destroy
    respond_to do |format|
      format.html { redirect_to polls_url, notice: "Poll \##{@poll.id} was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  # TODO: replace this action w/ checking on model level
  # Reloads voting & show pages to prevent poll cheating
#  def set_cache_headers
#    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
#    response.headers["Pragma"] = "no-cache"
#    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
#  end

  private 

  # Counts votes for building bars - Move to helper??
#  def count_votes
#    if Poll.voted_by_user(@poll, current_user) || @poll.closed?
#      @votes = []
#      voted_users = []
#      @poll.options.each_with_index do |option, index|
#        @votes.push(option.votes.size)
#        voted_users.push(option.votes.pluck(:user_id))
#      end
#      case @poll.poll_type
#        when 'radio'
#          @votes.push(@votes.inject(0){|sum,x| sum + x })
#        when 'check_box'
#          @votes.push(voted_users.uniq.count)
#      end
#    end
#  end
  
  # Set editing poll time limit
  def set_editing_time
    @editing_time = 10.hour
  end

  def set_poll
    @poll = Poll.find(params[:id])
  end

  def poll_params
    params.require(:poll).permit( :title, 
                                  :body, 
                                  :start, 
                                  :finish, 
                                  :state, 
                                  :poll_type, 
                                  :user_id, 
                                  :show_me, 
                                  :votes_count, 
                                  options_attributes: [:poll_option, :poll_id, :id, :_destroy]
                                  )
  end
end
