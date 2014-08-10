class BooksController < ApplicationController
  def index
    @books = Book.first(10)
  end

  def show
    @book = EPUB::Parser.parse(Book.find(params[:id]).filename)
  end
end
