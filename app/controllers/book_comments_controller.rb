class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book.new(book_comment_params)
    #上記１行はcomment = BookComment.new(book_comment_params)
    #とcomment.user_id = current_user.idを表す。
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
