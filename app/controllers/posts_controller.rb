class PostsController < ApplicationController
  before_action :authenticate_user!

  # Página que lista os posts
  def index
    @posts = Post.order(created_at: :desc) # Lista os posts mais recentes primeiro
  end

  # Página para criar um novo post
  def new
    @post = Post.new
  end

  # Criação do post
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

  # Ação para curtir o post
  def like
    @post = Post.find(params[:id])

    unless @post.likes.exists?(user: current_user)
      @post.likes.create(user: current_user)
      flash[:notice] = "Você curtiu o post!"
    else
      flash[:alert] = "Você já curtiu este post!"
    end

    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :content)
  end
end
