# encoding: utf-8
class Api::BooksController < ApiController
  before_action :set_api_book, only: [:show, :update, :destroy]

  # GET /api/books
  # GET /api/books.json
  def index
    ch = CommHandler.new(url: Settings.comm.group_call.url,req_body: "<vDisplayNbr>09913676865</vDisplayNbr><vAdminNbr>15309910500</vAdminNbr><vMemberNbr>09916697159|18690822170</vMemberNbr>")
    response=ch.group_call
    render json: {success: response.force_encoding('UTF-8')}
  end

  # GET /api/books/1
  # GET /api/books/1.json
  def show
    render json: @api_book
  end

  # POST /api/books
  # POST /api/books.json
  def create
    @api_book = Api::Book.new(api_book_params)

    if @api_book.save
      render json: @api_book, status: :created, location: @api_book
    else
      render json: @api_book.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/books/1
  # PATCH/PUT /api/books/1.json
  def update
    @api_book = Api::Book.find(params[:id])

    if @api_book.update(api_book_params)
      head :no_content
    else
      render json: @api_book.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/books/1
  # DELETE /api/books/1.json
  def destroy
    @api_book.destroy

    head :no_content
  end

  private

  def set_api_book
    @api_book = Api::Book.find(params[:id])
  end

  def api_book_params
    params.require(:api_book).permit(:name, :author)
  end
end
