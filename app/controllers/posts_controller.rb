class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_post, except: %i(new create)
  before_action :load_catalog, only: :create
  before_action :check_admin, except: :show

  def new
    @post = Post.new
  end

  def show; end

  def index; end

  def create
    @post = @catalog.posts.build post_params
    @post.user_id = current_user.id

    if @post.save
      flash[:success] = t("messages.create_success", name: @post.titleize_title)
      redirect_to catalog_path(params[:catalog_id])
    else
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @post.update_attributes post_params
      flash[:success] = t("messages.update_success", name: @post.titleize_title)
      redirect_to catalog_path(@post.catalog.id)
    else
      flash.now[:warning] = t "messages.update_failed"
      render :edit
    end
  end

  def destroy
    @post.destroy
    if @post.destroyed?
      respond_to :js
    else
      flash[:warning] = t("messages.delete_failed", name: @post.titleize_title)
      redirect_to catalog_path(params[:id])
    end
  end

  private

  def post_params
    params.require(:post).permit Post::POST_PARAMS
  end

  def load_catalog
    @catalog = Catalog.find_by id: params[:catalog_id]

    return if @catalog

    flash[:warning] = t("messages.not_exists", name: Catalog.name)
    redirect_to catalogs_path
  end

  def load_post
    @post = Post.find_by id: params[:id]

    return if @post

    flash[:warning] = t("messages.not_exists", name: Post.name)
    redirect_to catalogs_path
  end
end
