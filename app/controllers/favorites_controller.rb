class FavoritesController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    #favorites = その時ログインしているユーザーの
    favorite = current_user.favorites.new(book_id: book.id)
    #いいねを保存
    favorite.save
    #前のページにリダイレクト
    redirect_to request.referrer
  end

  def destroy
    book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: book.id)
    favorite.destroy
    redirect_to request.referrer
  end

end
