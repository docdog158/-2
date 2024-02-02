class BooksController < ApplicationController
   before_action :is_matching_login_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    #タグ機能
    @tag_list = @post_book.book_tags.pluck(:name).join(',')
    @post_book_tags = @post_book.book_tags
    #end
    @new = Book.new
    @user = @book.user
    @post_comment = PostComment.new
  end

  def index
    @book = Book.new
    #@books = Book.all
    @post_comment = PostComment.new
    #@books = Book.all.order(created_at: :desc)
    
    #タグ機能
    @tags = BookTag.all
    #リストの切り替え
    if params[:latest]
      @books = Book.latest
    elsif params[:old]
      @books = Book.old
    elsif params[:star_count]
      @books = Book.star_count
    else
      @books = Book.all
      
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    #タグ機能
    @tag_list = params[:book][:name].split(',')
    
    if @book.save
      #タグ機能
      @book.save_book_tags(tag_list)
      
      redirect_to book_path(@book), notice: "本の投稿ができました"
    else
      @books = Book.all
      #render :index
    end
  end
  
    def search_tag
      @tag_list = BookTag.all
      @tag = BookTag.find(params[:book_tag_id])
      @Book = @tag.book
    end
  
  

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render :edit
    end
  end

  def destroy
    
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to '/books'
  end

  private

  def book_params
    params.require(:book).permit(:title, :body, :image, :star)
  end
  
  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user.id == current_user.id
      redirect_to books_path
    end
  end
  
end
