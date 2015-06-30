# encoding: utf-8
module PageHelper

  def table_page
    %q{
    <div class="panel panel-default">
  <div class="panel-heading">
    <i class="icon-user-follow"></i>
    新建普通用户账号
  </div>
  <div class="panel-body">
    <div class="table-responsive">
      <table class="table table-striped b-t b-light">
        <thead>
          <tr>
            <th class="col-sm-2">id</th>
            <th class="col-sm-4">名称</th>
            <th class="col-sm-2">描述</th>
            <th class="col-sm-4">操作</th>

          </tr>
        </thead>
        <tbody>
          <% @info_types.each do |info_type|%>
            <tr>
              <td><%=info_type.id%></td>
              <td><%=info_type.name%></td>
              <td><%=info_type.desc%></td>
              <td>
                <%= operation_to @role_actions, "显示",  admin_info_type_path(info_type) %>
                <%= operation_to @role_actions, "编辑", edit_admin_info_type_path(info_type) %>
                <%= operation_to @role_actions, "删除",admin_info_type_path(info_type),  :confirm => 'Are you sure?', :method => :delete %>
              </td>
            </tr>
          <% end%>
        </tbody>
      </table>
    </div>
  </div>
</div>

    }
  end
end
