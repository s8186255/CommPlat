class Demo::Book
  include Mongoid::Document
  field :name, type: String
  field :author, type: String
  field :pagecount, type: Integer

  validates :author,presence: true,if: "name=='hello'"

  def hello

  end
end
