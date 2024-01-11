class Juice
  def initialize(name, price, number)
    @name = name
    @price = price
    @number = number
  end

  # 商品名参照
  def name
    @name
  end

  # 値段参照
  def price
    @price
  end

  # 在庫参照
  def number
    @number
  end

  # 在庫を減らす
  def stocks_consumption=(number)
    @number -= number
  end

  # 在庫を補充する
  def stocks_replenishment=(number)
    @number += number
  end
end
