# Suicaクラス、Juiceクラスを読み込む
require_relative './suica'
require_relative './juice_management'

# Juiceクラスを継承したPurchaseクラスと定義
class Purchase < Juice
  # 売上金額変数
  @@sales_amount = 0

  # 在庫参照
  attr_reader :number

  def initialize(name, price, number)
    # スーパークラスのinitializeメソッドを呼び出す
    super(name, price)
    @number = number
  end

  # 在庫を減らす
  def stocks_consumption=(number)
    @number -= number
  end

  # 在庫を補充する
  def stocks_replenishment=(number)
    @number += number
  end

  # クラスメソッドの定義
  class << self
    # 売上金額参照
    def sales_amount
      @@sales_amount
    end

    # 現在の売上金額を出力する
    def output_sales_amount
      puts "現在の売上金額は#{@@sales_amount}円です。"
    end

    # 購入可否の参照
    def to_decide
      @decide
    end

    # 購入するドリンクの判定
    def drink_to_decide(juice, juice_stocks)
      case juice.name
      when juice_stocks[0].name
        purchase_processing(juice, juice_stocks[0])
      when juice_stocks[1].name
        purchase_processing(juice, juice_stocks[1])
      when juice_stocks[2].name
        purchase_processing(juice, juice_stocks[2])
      end
    end

    # 購入処理
    def purchase_processing(juice, juice_stocks_array)
      # 「購入可能か判定する」メソッドの呼び出し
      # 購入数よりも在庫が多い場合
      if in_stock(juice_stocks_array, juice)
        # Suicaのチャージ残高が足りる場合
        if Suica.charge >= juice.price * juice.number
          # 「在庫を減らす処理」メソッドの呼び出し
          juice_stocks_array.stocks_consumption = juice.number
          # 「売上金額計上」メソッドの呼び出し
          increase_sales_amount(juice.price, juice.number)
          # 「「Suicaのチャージ残高を減らす」メソッドの呼び出し」メソッドの呼び出し
          Suica.reduce_balance_preprocessing(juice.price, juice.number)
        # Suicaのチャージ残高が足りない場合
        elsif Suica.charge <= juice.price * juice.number
          raise 'Suicaのチャージ残高が不足しています。'
        end
      # 在庫が0本の場合
      elsif juice_stocks_array.number.zero?
        raise "#{juice_stocks_array.name}の在庫がありません。"
      end
    end

    # 購入可能か判定する
    def in_stock(juice_stocks_array, juice)
      if (@decide = juice_stocks_array.number > juice.number || juice_stocks_array.number == juice.number)
        puts "#{juice_stocks_array.name}は購入可能です。"
      else
        puts "#{juice_stocks_array.name}は購入不可能です。"
      end
      # 「購入可否の参照」メソッドの呼び出し
      to_decide
    end

    # 「在庫を補充する処理」呼び出しメソッド
    def stocks_consumption_preprocessing(juice, juice_stocks)
      case juice.name
      when juice_stocks[0].name
        juice_stocks[0].stocks_replenishment = juice.number
      when juice_stocks[1].name
        juice_stocks[1].stocks_replenishment = juice.number
      when juice_stocks[2].name
        juice_stocks[2].stocks_replenishment = juice.number
      end
    end

    # 購入可能なドリンクをリストとして出力する
    def drink_list(juice_stocks)
      juice_stocks.each do |juice_stock|
        # puts "#{juice_stock.name}#{juice_stock.price}円が#{juice_stock.number}本あります。"
        puts "#{juice_stock.name}#{juice_stock.price}円は#{juice_stock.number}本まで購入可能です。"
      end
    end

    private

    # 売上金額計上
    def increase_sales_amount(price, number)
      @@sales_amount += price * number
    end
  end
end

# 「Suicaに任意の金額をチャージする」メソッドの呼び出し
Suica.charge_preprocessing(100)
# 「現在のSuicaのチャージ残高を取得する」メソッドの呼び出し
Suica.charge_balance

# 初期在庫にペプシ、モンスター、いろはすを5本ずつ追加する
# 購入可能なドリンクをリストとして取得するための配列に格納する
pepsi = Purchase.new('ペプシ', 150, 5)
monster = Purchase.new('モンスター', 230, 5)
irohasu = Purchase.new('いろはす', 120, 5)
juice_stocks = [pepsi, monster, irohasu]

# 「購入可能なドリンクをリストとして出力する」メソッドの呼び出し
Purchase.drink_list(juice_stocks)

# 購入用インスタンス
juice = Purchase.new('いろはす', 120, 1)

# 在庫補充用インスタンス
juice_monster = Purchase.new('いろはす', 120, 1)

# 「購入処理」メソッドの呼び出し
Purchase.drink_to_decide(juice, juice_stocks)
# 「現在の売上金額を出力する」メソッドの呼び出し
Purchase.output_sales_amount

# 「在庫補充」メソッド呼び出し
Purchase.stocks_consumption_preprocessing(juice_monster, juice_stocks)
