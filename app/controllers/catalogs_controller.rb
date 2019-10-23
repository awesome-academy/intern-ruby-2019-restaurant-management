class CatalogsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_catalog, except: %i(new index create)

  def new
    @catalog = Catalog.new
  end

  def show
    @pagy, @posts = pagy(@catalog.posts, items: Settings.pages.page_number)
  end

  def index
    @catalogs = Catalog.select(:id, :name, :description, :image).order(:name)
  end

  def create
    @catalog = Catalog.new catalog_params

    if @catalog.save
      flash[:success] = t("messages.create_success", name: @catalog.titleize_name)
      redirect_to catalogs_path
    else
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def edit; end

  def update
    if @catalog.update_attributes catalog_params
      flash[:success] = t("messages.update_success", name: @catalog.titleize_name)
      redirect_to catalogs_path
    else
      flash.now[:warning] = t "messages.update_failed"
      render :edit
    end
  end

  def destroy
    @catalog.destroy
    if @catalog.destroyed?
      flash[:success] = t("messages.delete_success", name: @catalog.titleize_name)
    else
      flash[:warning] = t "messages.delete_failed"
    end
    redirect_to catalogs_path
  end

  private

  def catalog_params
    params.require(:catalog).permit Catalog::CATALOG_PARAMS
  end

  def load_catalog
    @catalog = Catalog.find_by id: params[:id]

    return if @catalog

    flash[:notice] = t("messages.not_exists", name: Catalog.name)
    redirect_to catalogs_path
  end
end
