class BooksController < ApplicationController
  
  def index
    @user = current_user
    @book = Book.new
    @books = Book.all
  end
  
  def create
    @user = current_user
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book.id), notice:'You have creatad book successfully.'
    else
      render :index
    end
  end
  
  def show
    @new_book = Book.new
    @book = Book.find(params[:id])
    @user = User.find(@book.user.id)
    @book_comment = BookComment.new
  end
  
  def edit
    @book = Book.find(params[:id])
    if current_user.id != @book.user.id
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book.id), notice:'You have updated book successfully.'
    else
      render :edit
    end
  end
  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end
  
  # 投稿データのストロングパラメータ
  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
