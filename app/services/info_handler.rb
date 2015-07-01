# encoding: utf-8

class InfoHandler
  def initialize opts={}
    #如下参数与info有关
    @obj_info = opts[:info] # 获取info的信息 现阶段只有title属性
    @obj_info_type = opts[:info_type]
    @obj_user = opts[:user]
    @hash_item = opts[:items] #是一个hash,{item_type_id:item_type_id对应的value}
    #如下参数与info_type有关
    @hash_info_type = opts[:info_type] # {name:name,desc:desc}
    @hash_item_type = opts[:item_type] # {name:[n1,n2...],position:[p1,p2],content_type:[c1,c2],if_title:[t1,t2]},if_verify:[v1,v2]

  end

  def item_types
    @info_type.item_types
  end

  #参数@info_type，@items
  def create_info
    puts "@hash_item:"+@hash_item.to_s
    Rails.logger.debug '------------------'
    Rails.logger.debug @obj_info
    #创建info
    info = Info.new info_type_id: @obj_info_type.id,
                    user_id: @obj_user.id,
                    title: @obj_info[:title]
    if info.save
      #查找item_type,创建item
      #items =[]
      @obj_info_type.item_types.each do |item_type|
        Item.create_item item_type: item_type,
                         value: @hash_item["#{item_type.id}"],
                         info: info
        #优化插入效率 改为batch 批量插入
        #item = Item.new item_type: item_type,
                         #value: @hash_item["#{item_type.id}"],
                         #info: info
        #items << item.as_document
      end
      #Rails.logger.debug '-------------------'
      #Rails.logger.debug items
      #if !items.blank?
        #Item.collection.insert(items)
      #end
      return info
    else
      return false
    end
  end


  #参数@info
  def update_info
    #根据info，找到items,并修改每个item。
    Rails.logger.debug "-----------update_info----------------"

  end

  #参数@item_types，集合；
  #方式：
  # ih = InfoHandler.new(info_type:info_type,item_type:item_type)
  # ih.create_info_type
  def create_info_type
    success_flag = false
    return success_flag if @hash_info_type.nil? or @hash_item_type.nil?
    #创建info_type
    info_type = InfoType.new name: @hash_info_type[:name],
                             desc: @hash_info_type[:desc],
                             position: @hash_info_type[:position],
                             type: @hash_info_type[:type],
                             has_child: @hash_info_type[:has_child]
    if info_type.save
      #创建item_types
      #fields_number 字段数量,任选一个字段，计算item_type的数量
      fields_number = @hash_item_type[:name].size
      0.step fields_number-1 do |x|
        item_type = ItemType.new name: @hash_item_type[:name][x],
                                 position: @hash_item_type[:position][x].blank? ? 0 : @hash_item_type[:position][x].to_i,
                                 content_type: @hash_item_type[:content_type][x].to_i,
                                 if_title: @hash_item_type[:if_title][x].to_i,
                                 if_verify: @hash_item_type[:if_verify][x].to_i,
                                 info_type_id: info_type.id
        if item_type.save
          success_flag = true
        else

          info_type.destroy
          success_flag = false
          break
        end
      end
      return success_flag
    end


  end

  #参数@info_type
  def update_info_type
    #根据info_type,找到item_types,修改每个item_type。
  end

  #参数@info_type
  def disable_info_type
    #设置info_type的属性值
    {"utf8"=>"✓",
     "authenticity_token"=>"wuykG03ZlwtgrjsoHQqA1akvV8aRhnkCPpxkl2O40fNqUmwfXw8h2jFP8uuhm6KGVkAOPiUD8aRf4tQD7+K90w==",
     "info_type"=>{"name"=>"66",
                   "desc"=>"66"},
     "item_type"=>{"name"=>["55"],
                   "if_verify"=>["0"],
                   "if_title"=>["0"],
                   "position"=>[""],
                   "content_type"=>["1"]}}
  end
end
