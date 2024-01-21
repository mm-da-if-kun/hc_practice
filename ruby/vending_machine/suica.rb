class Suica
  # Suicaのチャージ残高参照
  attr_reader :charge

  def initialize
    # Sicaのチャージ残高
    @charge = 500
  end

  # Suicaの現在のチャージ残高を出力する
  def charge_balance
    puts "Suicaのチャージ残高は#{@charge}円です。"
  end

  # 「Suicaに任意の金額をチャージする」メソッドの呼び出し
  # Suicaのチャージ残高を直接外部から書き換えられないようにするための呼び出しメソッド
  def charge_preprocessing(price)
    add_to(price)
  end

  # 「Suicaのチャージ残高を減らす」メソッドの呼び出し
  def reduce_balance_preprocessing(price)
    reduce_balance(price)
  end

  private

  # Suicaに任意の金額をチャージする
  def add_to(price)
    raise '100円以上の金額をチャージしてください。' if price < 100

    @charge += price
  end

  # Suicaのチャージ残高を減らす
  def reduce_balance(price)
    @charge -= price
  end
end
