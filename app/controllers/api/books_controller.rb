class Api::BooksController < ApiController
  before_action :set_api_book, only: [:show, :update, :destroy]

  # GET /api/books
  # GET /api/books.json
  def index
    @api_books = Api::Book.all
    url1='http://api.open189.net:10035/xj/as/dial'
    url2='http://api.open189.net:10035/xj/as/meetstart?'
    timestamp = Time.now.strftime("%Y-%m-%d %H:%M:%S")
    access_token = '01b8d3d6d16a44af834f1a9f8b1ae28d'
    token_secret = '9e2de3b33c4021d77913faa89a0f92e4'
    sign= Digest::MD5.digest(access_token + timestamp + token_secret).unpack("H*")[0]
    str_params1 = %Q{
    access_token=938d2bdcb0f750ab8720901b66df67e31393902726651&
    timestamp=#{timestamp}&auth_token=&
    format=JSON&state=&sign=#{sign}&
    req_body=<vChargeNbr>09913676865</vChargeNbr><vDisplayNbr>09913676865</vDisplayNbr><vCallerNbr>09913676865</vCallerNbr><vCalledNbr>15309910500</vCalledNbr>
    }

    str_params2 = "access_token=#{access_token}&timestamp=#{timestamp}&auth_token=&format=JSON&state=&sign=#{sign}&req_body=<vDisplayNbr>09913676865</vDisplayNbr><vAdminNbr>09913676865</vAdminNbr><vMemberNbr>15309910500|18099209001</vMemberNbr>"


    json_params = {
        access_token: access_token,
        timestamp: timestamp,
        sign: Digest::MD5.digest(access_token + timestamp + token_secret).unpack("H*")[0],
        req_body: "<vDisplayNbr>09913676865</vDisplayNbr><vCallerNbr>09913676865</vCallerNbr><vCalledNbr>15309910500</vCalledNbr><vRecord>0</vRecord>"

    }
    #render json: @api_books
    RestClient.get url2+str_params2
    RestClient.post url1,json_params
    #Net::HTTP.post_form URI.parse(url1),json_params
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
