class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  # フォローするとき
  def create
    user = User.find(params[:id])  #提出後追記
    current_user.follow(params[:user_id])
    redirect_to request.referer
  end
  # フォロー外すとき
  def destroy
    user = User.find(params[:user_id]) #提出後追記
    current_user.unfollow(user) #提出後修正
    redirect_to request.referer
  end
  # フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end
  # フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end

end