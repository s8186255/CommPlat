create_tr = (type) ->
  tr = $("#new_" + type + "_tr")
  if tr.length == 0
    tr_html= '
      <tr id="new_' + type + '_tr">
      <td><input tyep="text" name="roles[' + type + '_permission][' + type + '_name]" placeholder="权限类型"  id="" value="" /></td>
      <td><input type="text" placeholder="描述" name="roles[' + type + '_permission][desc]" id="" value="" /></td>
      <td>
      <input type="text" placeholder="权限" name="roles[' + type + '_permission][actions]" id="" value="" /></td>
      <td></td>
      <td>
      <input type="submit" class="btn btn-default btn-sm"  value="新增" />
      <a onclick="cancel_create(\'' + type + '\')" id="create_cancel" class="btn btn-default btn-sm"  href="javascript:void(0)">取消</a>
      </td>
      </tr>
      '
    #permission_doc = $("." + type + "_permission")
    #if permission_doc.size() == 0
      #$("#new_" + type + "_permission").append(tr_html)
    #else
    $("#" + type + "_tbody").prepend(tr_html)
  else
    alert "已经新建过了"

window.cancel_create = (type)->
  $("#new_" + type + "_tr").remove()

$ ->
  $("a[data-permission]").click (e) ->
    e.preventDefault()
    create_tr $(this).data("permission")
