class PostsController < ApplicationController
  include CableReady::Broadcaster
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all
    respond_to do |format|
      format.html { render }
      format.json { render operations: cable_car.inner_html(@posts, html: self.class.render(@posts)) }
    end
  end

  # GET /posts/1
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
    render operations: cable_car.append(selector: "#posts", html: render_form(@post))
  end

  # GET /posts/1/edit
  def edit
    render operations: cable_car.outer_html(selector: @post, html: render_form(@post))
  end

  # POST /posts
  def create
    @post = Post.new(post_params)

    if @post.save
      render operations: cable_car
        .append(selector: "#posts", html: render_post(@post))
        .remove(selector: "#new_post")
    else
      render operations: cable_car.outer_html(selector: @post, html: render_form(@post))
    end
  end

  # PATCH/PUT /posts/1
  def update
    if @post.update(post_params)
      render operations: cable_car.outer_html(selector: @post, html: render_post(@post))
    else
      render operations: cable_car.outer_html(selector: @post, html: render_form(@post))
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    render operations: cable_car.remove(selector: @post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:content)
    end

    def render_post post
      self.class.render(post)
    end

    def render_form post
      self.class.render(partial: "form", locals: {post: post})
    end
end
