module Saq::FormInputHelper
  #左侧菜单项分项名称
  def text_input_field name, title, value
    %Q{
        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-id-1">#{title}</label>
          <div class="col-sm-10">
            <input type="text" class="form-control" id="input-id-1" name=#{name} value=#{value}>
          </div>
        </div>
    }.html_safe
  end

  def file_input_field name, title
    %Q{
        <div class="form-group">
          <label class="col-sm-2 control-label" for="input-id-1">#{title}</label>
          <div class="col-sm-10">
            <input type="file" class="form-control" id="input-id-1" name=#{name} >
          </div>
        </div>
    }.html_safe
  end

  def checkbox_input_field name, title, opts=[]
    items=''
    opts.each do |x|
      items += checkbox_item(name, x[:item_value], x[:item_display_name])
    end

    (%Q{
     <div class="form-group">
          <label class="col-sm-2 control-label">#{title}</label>
          <div class="col-sm-10">}+
            items +
            %Q{
          </div>
     </div>}).html_safe

  end

  def select_input_field name, title, opts=[] #opts的元素是hash{value:value,desc:desc}
    opts_str = ''
    opts.each { |x| opts_str += %Q{<option value='#{x[:value]}'>#{x[:desc]}</option>} }
    %Q{
    <div class="form-group">
          <label class="col-sm-2 control-label" for="input-id-1">#{title}</label>
          <div class="col-sm-10">
          <select name="#{name}" class="form-control m-b">
    #{opts_str}
          </select>
          </div>
    </div>
    }.html_safe

  end

  def checkbox_item item_name, item_value, item_display_name
    %Q{
      <label class="checkbox-inline i-checks">
        <input type="checkbox" name=#{item_name} value=#{item_value}>
        <i></i>
    #{item_display_name}
      </label>
    }.html_safe

  end

  def submit_button display_name
    %Q{
      <div class="form-group">
        <div class="col-sm-4 col-sm-offset-2">
          <button type="submit" class="btn btn-primary">#{display_name}</button>
        </div>
      </div>
    }.html_safe
  end

  def dash_line
    %Q{
      <div class="line line-dashed b-b line-lg pull-in"></div>
    }.html_safe
  end

  def ajax_upload_file_field element_id
    %Q{
      <input id="fileupload" type="file" name="upfile" data-url="/attachment/upload" multiple>
      <script src="/js/jquery.ui.widget.js"></script>
      <script src="/js/jquery.iframe-transport.js"></script>
      <script src="/js/jquery.fileupload.js"></script>
      <script>
      $(function () {
          $('#fileupload').fileupload({
              dataType: 'json',
              success: function (data) {
                alert(data.background_img_id);
                $("#{element_id}").css("background-image","url("+data.url+")");
                $("input[name='background_img_id']").val(data.background_img_id);
              }
          });
      });
      </script>
    }.html_safe
  end

  def ajax_upload_photo
    %Q{
      <input id="fileupload" type="file" name="upfile" data-url="/attachment/upload" multiple>
      <script src="/js/jquery.ui.widget.js"></script>
      <script src="/js/jquery.iframe-transport.js"></script>
      <script src="/js/jquery.fileupload.js"></script>
      <script>
      $(function () {
          $('#fileupload').fileupload({
              dataType: 'json',
              success: function (data) {
                alert(data.background_img_id);
                alert(data.url);
                $("#photo").attr("src", data.url);
                $("input[name='background_img_id']").val(data.background_img_id);

  var $image = $('#cropper-example-2 > img'),
    cropBoxData,
  canvasData;
    $image.cropper('destroy');
                $image.cropper({
                  autoCropArea: 1,
                  preview: '.img-preview'
                });
              }
          });
      });
      </script>
    }.html_safe
  end
end

