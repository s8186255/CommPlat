# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
def create_role(role_name,role_desc, info_types_or_controller_with_actions={} )
  role = Role.create(name: role_name, desc: role_desc)
  info_types_or_controller_with_actions.each  do |key,value|
    controller_permission = ControllerPermission.new
    controller_permission.controller_name = key
    controller_permission.actions = value
    controller_permission.role = role
    controller_permission.save
  end
end
Role.destroy_all
create_role("admin","管理员", { info_types: [:manager], users: [:manager], roles: [:manager] })
p "建立管理员角色完毕"
create_role("info_manager","信息管理员", { users: [:read]})
p "建立信息管理员角色完毕"
create_role("exhibitor", "参展商", {article: [:manager]})
p "建立参展商角色完毕"
create_role("professional_visitor", "专业观众", {article: [:manager]})
p "建立专业观众角色完毕"
u = User.new(username: "admin", password: "321321", email: "admin@bobo.im")
u.role = Role.first
u.save

