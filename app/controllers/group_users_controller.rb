class GroupUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_group_user, only: [:show, :edit, :update, :destroy]

  # GET /group_users
  # GET /group_users.json
  def index
    @group_users = GroupUser.all
  end

  # GET /group_users/1
  # GET /group_users/1.json
  def show
  end

  # GET /group_users/new
  def new
    @group_user = GroupUser.new
  end

  # GET /group_users/1/edit
  def edit
  end

  # POST /group_users
  # POST /group_users.json
  def create
    #@group_user = GroupUser.new(group_user_params)
    @group = Group.find(params[:group_id])
    @group_user = @group.group_users.build(:user_id => params[:user_id] , :group_id => params[:group_id])

    respond_to do |format|
      if @group_user.save
        format.html { redirect_to group_users_path(@group_user), notice: ' your friend add to group ' +@group.name + '  successfully .' }
  
        format.json { render :show, status: :created, location: @group_user }
      else
        format.html { render :new }
        format.json { render json: @group_user.errors, status: :unprocessable_entity }
              redirect_to root_url

      end
    end
  end

  # PATCH/PUT /group_users/1
  # PATCH/PUT /group_users/1.json
  def update
    respond_to do |format|
      if @group_user.update(group_user_params)
        format.html { redirect_to @groups, notice: 'Group user was successfully updated.' }
        format.json { render :show, status: :ok, location: @group_user }
      else
        format.html { render :edit }
        format.json { render json: @group_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /group_users/1
  # DELETE /group_users/1.json
  def destroy
    @group_user = GroupUser.find(params[:id])
    @group_user.destroy
    
    respond_to do |format|
      format.html { redirect_to group_users_url, notice: ' your friend was successfully removed from group ' +@group_user.group.name }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_group_user
      @group_user = GroupUser.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def group_user_params
      params.require(:group_user).permit(:user_id, :group_id)
    end
end






