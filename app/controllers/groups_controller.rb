class GroupsController < ApplicationController
  before_action :authenticate_user! , only: [:new, :creation]
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @group = Group.find(params[:id])
  end

  def  update
    @group = Group.find(params[:id])
    if  @group.update(group_params)
      redirect_to groups_path, notice: "Update Success!"
    else
      render :edit
    end
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.user = current_user
    
    if @group.save
      redirect_to groups_path
    else
      render :new
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:alert] = "GROUP DELETED!"
    redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit(:title, :description)
  end

end
