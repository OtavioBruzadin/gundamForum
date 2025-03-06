class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.order(created_at: :desc) # Lista os posts mais recentes primeiro
  end


  def new

    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    @post.date = Time.current
    @post.author = current_user.name # Define o usuário como autor
    @post.likes ||= 0 # Garante que likes começa em 0

    if @post.save
      flash[:notice] = "Post criado com sucesso!"
      redirect_to root_path
    else
      flash[:alert] = "Erro ao criar o post: #{@post.errors.full_messages.join(', ')}"
      render :new
    end
  end

  def like
    @post = Post.find(params[:id])
    like = @post.likes.find_by(user: current_user)

    if like
      like.destroy
    else
      @post.likes.create(user: current_user)
    end

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_to request.referer || root_path }
    end
  end

  class PostsController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]

    def show
      @post = Post.find(params[:id])
      @comments = @post.comments.order(created_at: :asc)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :content)
  end
end
