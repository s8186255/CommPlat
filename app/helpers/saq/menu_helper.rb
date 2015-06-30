module Saq::MenuHelper
  #左侧菜单项分项名称
  def side_menu_name name
    %Q{
      <a href="" class="auto">
          <span class="pull-right text-muted">
            <i class="fa fa-fw fa-angle-right text"></i>
            <i class="fa fa-fw fa-angle-down text-active"></i>
          </span>
      <i class="glyphicon glyphicon-th"></i>
      <span>#{name}</span>
      </a>
      }.html_safe
  end
  #左侧的菜单项
  def side_menu_item url,name
    %Q{
      <li>
      <a href=#{url}>
      <span>#{name}</span>
      </a>
      </li>
    }.html_safe
  end
end
