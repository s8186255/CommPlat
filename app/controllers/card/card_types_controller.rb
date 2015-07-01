# encoding: utf-8
class Card::CardTypesController < Card::BaseController
  before_action :set_card_type, only: [:show, :edit, :update, :destroy]

  # skip_before_action :role_user!
  #列出卡类型
  def index
    @card_types = CardType.all.page(params[:page])
  end

  #新建卡类型 new，create
  def new
    @card_type=CardType.new
    @applicant_type_opts = []
    Settings.applicant_type.all.each{|x| @applicant_type_opts<<{value: x.name,desc:x.desc}}
    render "new_step_one"
  end

  def new_step_two
    opts={"a"=>1,"b"=>2}
    puts params['applicant_type']
    @applicant_type = Settings.applicant_type[params[:applicant_type]]
    set_step_params self.action_name,"applicant_type"=> params["applicant_type"]

    @card_type = CardType.new
    @format_string = CardType.type_one(@applicant_type).to_s.gsub(/\=\>/, ':')

  end

  def show
    @format_string = @card_type.format.to_s.gsub(/\=\>/, ':')
    @applicant_type = Settings.applicant_type[@card_type.applicant_type]
  end

  def create
    @card_type = CardType.new card_type_params.merge({:format => eval(card_type_params[:format].gsub(/\:/, '=>'))})
    @card_type.applicant_type = get_step_params["new_step_two"]["applicant_type"]
    if @card_type.save
      unless params["background_img_id"].blank?
        background_img = Attachment::Image.find_by(id: params["background_img_id"])
        unless background_img.nil?
          background_img.update_attributes card_type_id: @card_type.id
        end
      end

      flash[:notcie] = "新建成功"
      redirect_to card_card_types_path
    else
      render :new
    end
  end

  #更新卡类型 edit，update
  def edit
    @format_string = @card_type.format.to_s.gsub(/\=\>/, ':')
    @applicant_type = Settings.applicant_type[@card_type.applicant_type]
  end

  def update

    format = eval(card_type_params[:format].gsub(/\:/, '=>'))
    if @card_type.update_attributes(card_type_params.merge({:format => format}))
      unless params["background_img_id"].blank?
        background_img = Attachment::Image.find_by(id: params["background_img_id"])
        unless background_img.nil?
          background_img.update_attributes card_type_id: @card_type.id
        end
      end
      flash[:notice] = "更新成功"
    else
      flash[:error] = "更新失败"
    end
    redirect_to :action => 'index'
  end

  def destroy
    if @card_type.expos.blank? and @card_type.cards.blank?
      @card_type.destroy
      flash[:notice] = "删除成功"
      redirect_to :action => 'index'
    else
      flash[:error] = "有展会正在使用此类型的卡片无法删除"
      redirect_to :action => 'index'
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_card_type
    @card_type = CardType.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_type_params
    params[:card_type].permit(:name, :price, :image, :format)
    #params[:card_type][:format]= eval params[:card_type][:format].gsub(/\:/,'=>')
  end

  def merge_old_new_card_format old_format={},new_format={}
    old_format.merge(new_format) do |k, v_old, v_new|
      v_new.blank? ? v_old : v_new
    end
  end

  def set_title
    @title = "卡证类型管理"
  end

end
