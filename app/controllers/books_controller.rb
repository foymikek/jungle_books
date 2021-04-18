class BooksController < ApplicationController
  def index
    render json: Book.all
  end

  def create
    book = Book.new(author: params[:author], title: params[:title])

    if book.save
      render json: book, status: :created
    else
      render json: book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    # return true if the book is found and destroyed
    Book.find_by(id: params[:id]).destroy!
    # not returning a json response. No body, just a head response. 204
    # no reason to return a body here as the record is being deleted.
    head :no_content
  end

  private

  def book_params
    params.require(:book).permit(:title, :author)
  end

end