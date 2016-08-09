class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :get_categories, only: :index

  def get_categories
    @categories = Category.all
  end

  # GET /posts
  # GET /posts.json
  def index
    @category_name = params[:category_name] || 'All'
    @show_me = params[:show_me] || 'all'
    case @show_me
    when 'all'
      if @category_name == 'All'
        @posts = Post.published.order(created_at: :desc).page params[:page]
      else
        category = Category.where(:name => @category_name).first
        @posts = category.posts.published.order(created_at: :desc).page params[:page]
      end
    when 'my'
      if @category_name == 'All'
        @posts = current_user.posts.order(is_draft: :asc, created_at: :desc).page params[:page]
      else
        category = Category.where(:name => @category_name).first
        @posts = category.posts.where(user: current_user).order(is_draft: :asc, created_at: :desc).page params[:page]
      end
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    commontator_thread_show(@post)
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post.post_categories.build
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def set_category
    category_name = params[:category_name]
    show_me = params[:show_me]
    action_name = Rails.application.routes.recognize_path(request.referrer)[:action]
    controller_name = Rails.application.routes.recognize_path(request.referrer)[:controller]
    redirect_to controller: controller_name, action: action_name, category_name: category_name, show_me: show_me
  end

  private

    def set_post
      @post = Post.find(params[:id])
    end
  
    def post_params
      params.require(:post).permit( :title, 
                                    :body, 
                                    :user_id, 
                                    :is_pinned, 
                                    :is_draft, 
                                    :commentable,
                                    :category_name,
                                    :show_me,
                                    post_categories_attributes: [:category_id, :post_id, :id]
                                    )
    end
end