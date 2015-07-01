module Saq::CardHelper
  #左侧菜单项分项名称
  def edit_card_font_tool
    %Q{
      <select id="fs">
          <option value="SimSun">宋体</option>
          <option value="NSimSun ">新宋体 </option>
          <option value="SimHei ">黑体 </option>
          <option value="Microsoft YaHei">微软雅黑</option>
          <option value="KaiTi_GB2312">楷体</option>
          <option value="LiSu">隶书</option>
          <option value="YouYuan ">幼园 </option>
          <option value="STXihei ">华文细黑 </option>
          <option value="MingLiU">细明体</option>
          <option value="PMingLiU">新细明体</option>
      </select>

      <select id="size">
          <option value="7">7</option>
          <option value="10">10</option>
          <option value="20">20</option>
          <option value="30">30</option>
          <option value="20">40</option>
          <option value="50">50</option>
          <option value="60">60</option>
          <option value="70">70</option>
      </select>
      <span id="delete_field" style="border:solid;border-width:1px;color:red;cursor:default">删除选中字段</span>
      <span id="add_field" style="border:solid;border-width:1px;color:green;cursor:default">添加选中字段</span>
      }.html_safe
  end


  # 显示卡类型内容
  # opts 是card_type.format;initial_opts是初始化的format
  def new_card_type applicant_type
    initial_opts = CardType.type_one applicant_type
    fields = ''
    CardType.fields_of(applicant_type).each do |x|
      fields += %Q{<label id="#{x}" class="card_field" style="left:#{initial_opts["#{x}"]["left"]};top:#{initial_opts["#{x}"]["top"]};font-size:#{initial_opts["#{x}"]["font-size"]};font-family:#{initial_opts["#{x}"]["font-family"]};">#{x}</label>}
    end
    (%Q{
      <style type="text/css">
      .card_field { border-style: dashed;border-width: 2px;border-color: blue;position:absolute;}
      #card{background-repeat:no-repeat;}
      </style>
      <div id="card" class="resizable ui-widget-content" style="width: #{initial_opts["card"]["width"]};height:#{initial_opts["card"]["height"]}">
      <div id="avatar" class="card_field resizable" style="left:#{initial_opts["avatar"]["left"]};top:#{initial_opts["avatar"]["top"]};width:#{initial_opts["avatar"]["width"]};height:#{initial_opts["avatar"]["height"]}"><img src="/1_b.jpg"  alt="示意图"  width="100%" height="100%" /></div>
    } +
        fields +
        %Q{
    </div>
    }).html_safe
  end

  def edit_card_type applicant_type, card_type=CardType.new
    card_background_img = unless card_type.image.nil?
                            card_type.image.asset.url
                          end
    fields = ''
    initial_opts = CardType.type_one applicant_type
    opts=card_type.format

    CardType.fields_of(applicant_type).each do |x|
      if opts.keys.member?(x)
        fields += %Q{<label id="#{x}" class="card_field" style="left:#{opts["#{x}"]["left"]};top:#{opts["#{x}"]["top"]};font-size:#{opts["#{x}"]["font-size"]};font-family:#{opts["#{x}"]["font-family"]};">#{x}</label>}
      else
        fields += %Q{<label id="#{x}" class="card_field" style="border-color:black;left:#{initial_opts["#{x}"]["left"]};top:#{initial_opts["#{x}"]["top"]};font-size:#{initial_opts["#{x}"]["font-size"]};font-family:#{initial_opts["#{x}"]["font-family"]};">#{x}</label>}
      end
    end


    (%Q{
      <style type="text/css">
      .card_field { border-style: dashed;border-width: 2px;border-color: blue;position:absolute;}
      #card{background-repeat:no-repeat;background-image:url("#{card_background_img}");}
      </style>
      <div id="card" class="resizable ui-widget-content" style="width: #{opts["card"]["width"]};height:#{opts["card"]["height"]}">
      <div id="avatar" class="card_field resizable" style="left:#{opts["avatar"]["left"]};top:#{opts["avatar"]["top"]};width:#{opts["avatar"]["width"]};height:#{opts["avatar"]["height"]}"><img src="/1_b.jpg"  alt="示意图"  width="100%" height="100%" /></div>
    } +
        fields +
        %Q{
    </div>
    }).html_safe
  end


  #显示卡片
  def card card=Card.new
    opts = card.card_type.format
    fields = ''
    card.card_type.format.each do |k, v|
      unless k == "card" || k== "avatar"
        fields += %Q{
                   <label id="#{k}" class="card_field" style="left:#{opts["#{k}"]["left"]};top:#{opts["#{k}"]["top"]};font-size:#{opts["#{k}"]["font-size"]};font-family:#{opts["#{k}"]["font-family"]};">#{card["#{k}"]}</label>
                  }
      end
    end

    (%Q{
    <style type="text/css">
    .card_field {position:absolute;}
    #card{background-image:no-repeat}
    </style>
    <div id="card" class="card_field resizable ui-widget-content" style="width: #{opts["card"]["width"]};height:#{opts["card"]["height"]}">
      <div id="avatar" class="card_field resizable" style="left:#{opts["avatar"]["left"]};top:#{opts["avatar"]["top"]};width:#{opts["avatar"]["width"]};height:#{opts["avatar"]["height"]}"><img src="/1_b.jpg"  alt="示意图"  width="100%" height="100%" /></div>
    } +
        fields +
        %Q{
    </div>
    }).html_safe
  end

  def config_card_js card_type = CardType.new,applicant_type
    format_str = CardType.type_one(applicant_type).to_s.gsub(/\=\>/, ':')
    %Q{
      <link rel="stylesheet" href="//code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css">
      <script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>

      <script>

          $(function () {
              var focus_el = '';
              var card_json = #{format_str};
              $(".resizable").resizable(
                      {
                          stop: function (event, ui) {
                              card_json[$(this).attr('id')].width = $(this).outerWidth().toString()+'px';
                              card_json[$(this).attr('id')].height = $(this).outerHeight().toString()+'px';
                              getElementParams(card_json);
                          }
                      }
              );

              $(".card_field").draggable({
                  containment: "parent",
                  stop: function () {
                      card_json[$(this).attr('id')].left = $(this).css('left');
                      card_json[$(this).attr('id')].top = $(this).css('top');
                      getElementParams(card_json);
                  }
              }).click(function () {
                  $(".card_field").css("border-color","blue");
                  $(this).css("border-color","red");
                  focus_el = $(this).attr('id');
              });


              $("#fs").change(function () {
                  if (focus_el == "") {
                      alert("请选中修改目标");
                  }
                  else {
                      $('#' + focus_el).css("font-family", $(this).val());
                      card_json[focus_el]['font-family'] = $('#' + focus_el).css('font-family');
                      getElementParams(card_json);
                  }
              });

              $("#size").change(function () {
                  if (focus_el == "") {
                      alert("请选中修改目标");
                  }
                  else {
                      $('#' + focus_el).css("font-size", $(this).val() + "px");
                      card_json[focus_el]['font-size'] = $('#' + focus_el).css('font-size');
                      getElementParams(card_json);
                  }
              });
              $("#delete_field").click(function () {
                  if (focus_el == "") {
                      alert("请选中修改目标");
                  }
                  else {
                      $('#' + focus_el).remove();
                      delete card_json[focus_el];
                      getElementParams(card_json);
                  }
              });
              $("#add_field").click(function () {
                  if (focus_el == "") {
                      alert("请选中修改目标");
                  }
                  else {
                      card_json[focus_el]={'font-size':$('#'+focus_el).css('font-size'),'font-family':$('#'+focus_el).css('font-family'),'left':$('#'+focus_el).css('left'),'top':$('#'+focus_el).css('top')};
                      getElementParams(card_json);

                  }
              });
          });

          function getElementParams(card_json){
            $(".card_field").each(function(i,field){
                if(field.id=='card'||field.id=='avatar'){
                    card_json[field.id].width = $('#'+field.id).outerWidth().toString()+'px';
                    card_json[field.id].height = $('#'+field.id).outerHeight().toString()+'px';
                    card_json[field.id].left = $('#'+field.id).css('left');
                    card_json[field.id].top = $('#'+field.id).css('top');
                }
                else{

                    card_json[field.id]["font-size"] = $('#'+field.id).css('font-size');
                    card_json[field.id]['font-family'] = $('#'+field.id).css('font-family');
                    card_json[field.id].left = $('#'+field.id).css('left');
                    card_json[field.id].top = $('#'+field.id).css('top');
                }
            })
            $("#card_format").val(JSON.stringify(card_json));
          }
      </script>
    }.html_safe
  end

  def card_style
    card_type=CardType.find_by id: '55713a940ca32bc0b2000001'
    page_width= ((card_type.format["card"]["width"].to_i)/3.87).to_s+'mm'
    page_height=((card_type.format["card"]["height"].to_i)/3.87).to_s+'mm'
    %Q{
      <style>

      .page {
          width: #{page_width};
          height: #{page_height};
          border-radius: 5px;
          padding: 0;
          margin:0;
      }



      @media print {
          @page {
              size: #{page_width} #{page_height} ;
              margin: 0;
          }
          .page {
              margin: 0;
              background: white;
              width: #{page_width};
              height: #{page_height};
              padding: 0;
              border-style:none !important;
              page-break-after: always;
          }
          .ui-widget-content {border-style:none !important}
          .ui-icon-gripsmall-diagonal-se {display:none !important}
      }
      </style>
    }.html_safe
  end

  def card_style_bak
    %Q{
      <style>
      body {
          margin: 0;
          padding: 0;
          background-color: #FAFAFA;
          font: 12pt "Tahoma";

      }

      * {
          box-sizing: border-box;
          -moz-box-sizing: border-box;
      }

      .page {
          width: 21cm;
          min-height: 29.7cm;
          padding: 2cm;
          margin: 1cm auto;
          border: 1px #D3D3D3 solid;
          border-radius: 5px;
          background: white;
          box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
      }

      .subpage {
          padding: 1cm;
          border: 5px red solid;
          height: 256mm;
          outline: 2cm #FFEAEA solid;
      }

      @page {
          size: 4in 4in;
          margin: 0;
      }

      @media print {
          .page {
              margin: 0;

              width: 210mm;
              height: 297mm;
          }
      }
      </style>
    }.html_safe
  end

  def card_input_field name, title, value,type
    if type=="String"
      text_input_field name, title, value
    elsif type=='File'
      file_input_field name, title
    else
       #   text_input_field name, display_name, value
    end

  end
end
