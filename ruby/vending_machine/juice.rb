class Juice
  # 商品、値段参照
  attr_reader :name, :price

  def initialize(name, price)
    # 商品名、値段
    @name = name
    @price = price
  end
end
