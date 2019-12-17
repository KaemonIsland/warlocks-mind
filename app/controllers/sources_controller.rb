class SourcesController < ApplicationController
  before_action :set_source, only: [:edit, :update, :destroy]
  before_action :has_permission


  def index
    @sources = current_user.sources
  end

  def new
    @source = current_user.sources.new()
  end

  def edit
  end

  def create
    @source = current_user.sources.create(source_params)

    if @source.save
      flash[:success] = "#{@source.name} has been added to your source list"
      redirect_to sources_path
    else
      render "new"
    end
  end

  def update
    if @source.update_attributes(source_params)
      flash[:success] = "#{@source.name} has been updated"
      redirect_to sources_path
    else
      render "edit"
    end
  end

  def destroy
    if @source.destroy
      flash[:success] = "#{@source.name} has been deleted"
      redirect_to sources_path
    else
      flash[:danger] = "Unable to delete #{@source.name}"
    end
  end

  private

  def source_params
    params.require(:source).permit(:name)
  end

  def set_source
    @source = current_user.sources.find(params[:id])
  end

  def has_permission
    require_permission current_user
  end
end
