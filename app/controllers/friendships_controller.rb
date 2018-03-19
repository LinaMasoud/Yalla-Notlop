class FriendshipsController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.select("email")
    # @friendships=Friendship.all
    @friendships = Friendship.where(user_id: current_user.id)
    if params[:search]
      @usersearch = User.search(params[:search]).order("created_at DESC")
    else
      @usersearch = nil
    end
  end
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
    if @friendship.save
      render json: {error:false, msg:"friendship created", user: User.find(params[:friend_id]), image: User.find(params[:friend_id]).image.url }
    else
      render json: {error:true, msg:"friendship not created"}
    end
  end
  
  def destroy
    @friendship = Friendship.where(user_id: current_user.id, friend_id:params[:id]).first
    if @friendship.destroy
         render json: {error:false, msg:"friendship destroied"}
    else
      render json: {error:true, msg:"friendship not destroiy"}
    end
    #flash[:notice] = "Removed friendship."
    #redirect_to friendships_path
  end
  def find
    @friend = User.where(email: params[:fmail]).take
    @res = Hash.new
    if @friend.present?
      if check_if_self @friend.id
        @res = { error: true, message: "Can't Be Friend of your self !!" }
      elsif check_if_friend @friend.id
        @res = { error: true, message: @friend.name+" is already in your friend list" }
      else
        @friendship = current_user.friendships.build(:friend_id => @friend.id)
        if @friendship.save
          @res = { error: false, message: @friend.name+" added to your friend list" }
        else
          @res = { error: true, message: "Unable to add "+@friend.email+" to your friend list" }
        end
      end
    else
      @res = {error: true, message: params[:fmail]+" doesn't exist"}
    end
    render json: @res
  end
  def check_if_friend(friend_id)
      @friendship = Friendship.where(user_id: current_user.id, friend_id: friend_id).take
      if @friendship.present?
        return true
      else
        return false
      end
    end

    def check_if_self(friend_id)
      if friend_id == current_user.id
        return true
      else
        return false
      end
  end



end