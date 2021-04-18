module Api
  module V1
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
        Book.find_by(id: params[:id]).destroy!
      
        head :no_content
      end
    
      private
    
      def book_params
        params.require(:book).permit(:title, :author)
      end
    
    end
  end
end