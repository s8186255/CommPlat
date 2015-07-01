class Demo::BooksController < ApplicationController
  before_action :set_demo_book, only: [:show, :edit, :update, :destroy]

  # GET /demo/books
  # GET /demo/books.json
  def index
    @demo_books = Demo::Book.all
  end

  # GET /demo/books/1
  # GET /demo/books/1.json
  def show
  end

  # GET /demo/books/new
  def new
    @demo_book = Demo::Book.new
  end

  # GET /demo/books/1/edit
  def edit
  end

  # POST /demo/books
  # POST /demo/books.json
  def create
    @demo_book = Demo::Book.new(demo_book_params)

    respond_to do |format|
      if @demo_book.save
        format.html { redirect_to @demo_book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @demo_book }
      else
        format.html { render :new }
        format.json { render json: @demo_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /demo/books/1
  # PATCH/PUT /demo/books/1.json
  def update
    respond_to do |format|
      if @demo_book.update(demo_book_params)
        format.html { redirect_to @demo_book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @demo_book }
      else
        format.html { render :edit }
        format.json { render json: @demo_book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /demo/books/1
  # DELETE /demo/books/1.json
  def destroy
    @demo_book.destroy
    respond_to do |format|
      format.html { redirect_to demo_books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_demo_book
      @demo_book = Demo::Book.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def demo_book_params
      params.require(:demo_book).permit(:name, :author, :pagecount)
    end
end
