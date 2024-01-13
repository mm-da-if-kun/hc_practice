class Juice
  # 商品、値段参照
  attr_reader :name, :price

  def initialize(name, price)
    @name = name
    @price = price
  end
end
