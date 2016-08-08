class PollsController < ApplicationController
  before_action :authenticate_user!
  #before_action :set_cache_headers, only: [:voting, :show ]
  before_action :set_poll,          only: [:voting, :show, :edit, :update, :destroy]
  before_action :set_editing_time,  only: [:edit, :show, :index]
  #before_action :user_can_vote?,    only: [:voting, :show]
  before_action :count_votes,       only: [:show]

  # Set editing poll time limit
  def set_editing_time
    @editing_time = 3.hour
  end

  # GET /polls
  # GET /polls.json
  # List of all polls in app
  def index
    @show_me = params[:show_me] || 'all'
    case @show_me
    when 'all'
      @polls = Poll.all.order(state: :asc, created_at: :desc).page params[:page]
    when 'my'
      @polls = current_user.polls.order(state: :asc, created_at: :desc).page params[:page]
    end
  end
  
  # GET /polls/1
  # GET /polls/1.json
  def show
  end

  # GET /polls/new
  def new
    @poll = Poll.new
    @poll.options.build
  end

  # GET /polls/1/edit
  def edit
    if (DateTime.now.to_i - @poll.created_at.to_i) > @editing_time
      respond_to do |format|
        format.html { redirect_to @poll, alert: "Sorry! You can't edit this poll, 'cause editing time is over." }
      end   
    end
  end

  # GET /polls/1/voting
  def voting
    unless user_can_vote?
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
      if @poll.update(poll_params) #&& save_poll_options
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
  
  # Check can user vote or not? - for refactoring - gem acts_as_votable
  def user_can_vote?
    @poll.options.each do |poll_option|
      if poll_option.votes.pluck(:user_id).include? current_user.id
        @voted = true
        false
        return
      else
        @voted = false
        true
      end
    end  
  end

  # Reloads voting & show pages to prevent poll cheating
  def set_cache_headers
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end
  
  # Counts votes for building bars - Move to helper??
  def count_votes
    if @voted || @poll.closed?
      @votes = []
      voted_users = []
      @poll.options.each_with_index do |option, index|
        @votes.push(Vote.where(:option_id => option.id).count)
        voted_users.push(option.votes.pluck(:user_id))
      end
      case @poll.poll_type
        when 1
          @votes.push(@votes.inject(0){|sum,x| sum + x })
        when 2
          @votes.push(voted_users.uniq.count)
      end
    end
  end
  
  private    
    # Validates start & finish datetimes
    def check_poll_datetime
      if @poll.finish > @poll.start && @poll.start > DateTime.now && @poll.finish > DateTime.now 
        return true 
      else
        flash[:alert] = "You set the wrong start or finish time."
        return false
      end
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
                                    options_attributes: [:poll_option, :poll_id, :id, :_destroy]
                                    )
    end
end
