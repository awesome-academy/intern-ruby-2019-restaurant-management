class TablesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, except: %i(show index)
  before_action :load_table, only: %i(show edit update destroy)

  def new
    @table = Table.new
  end

  def index
    @pagy, @tables = pagy(Table.select(:id, :description, :type_table),
      items: Settings.pages.page_number)
  end

  def show; end

  def edit; end

  def create
    @table = Table.new table_params

    if @table.save
      flash[:success] = t("messages.create_success", name: @table.id)
      redirect_to tables_path
    else
      flash.now[:warning] = t "messages.create_failed"
      render :new
    end
  end

  def update
    if @table.update_attributes table_params
      flash[:success] = t("messages.update_success", name: @table.id)
      redirect_to tables_path
    else
      flash.now[:warning] = t "messages.update_failed"
      render :edit
    end
  end

  def destroy
    @table.destroy
    if @table.destroyed?
      respond_to :js
    else
      flash[:warning] = t("messages.delete_failed", name: @table.id)
      redirect_to discounts_path
    end
  end

  private

  def table_params
    params.require(:table).permit Table::TABLE_PARAMS
  end

  def load_table
    @table = Table.find_by id: params[:id]

    return if @table

    flash[:notice] = t("messages.not_exists", name: Table.name)
    redirect_to tables_path
  end
end
