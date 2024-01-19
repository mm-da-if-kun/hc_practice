# Suicaクラス、Juiceクラスを読み込む
require_relative './suica'
require_relative './juice_management'

class VendinMachine
  # 在庫、売上金額参照
  attr_reader :stock, :sales

  def initialize
    # 在庫
    @stock = []
    5.times do
      @stock << Juice.new('ペプシ', 150) << Juice.new('モンスター', 230) << Juice.new('いろはす', 120)
    end

    # 売上金額
    @sales = 0
  end

  # 購入可否の判定
  def decide(target_juice)
    juice_decide = @stock.find_index { |stock| stock.name == target_juice.name }
    puts "#{target_juice.name}は購入可能です。" unless juice_decide.nil?
    puts "#{target_juice.name}は購入できません。" if juice_decide.nil?
  end

  # 購入処理
  def buy(suica, target_juice)
    juice_index = @stock.find_index { |stock| stock.name == target_juice.name }
    raise '在庫がありません' if juice_index.nil?

    price = target_juice.price
    raise '残高が足りません' if price > suica.charge

    # 在庫を減らす
    @stock.delete_at(juice_index)

    # 売上金額を増やす
    appropriation(price)
    # 「「Suicaのチャージ残高を減らす」メソッドの呼び出し」メソッドの呼び出し
    suica.reduce_balance_preprocessing(price)
  end

  # 現在の売上金額を出力する
  def output_sales
    puts "現在の売上金額は#{@sales}円です。"
  end

  # 購入可能なドリンクリストを出力する
  def juice_list
    stock_list = @stock.group_by { |juice| juice.name }
    stock_list.each_key do |list_key|
      puts "#{list_key}は#{stock_list[list_key].length}本まで購入可能です。"
    end
  end

  # 在庫を補充する
  def replenishment(name, price)
    @stock << Juice.new(name, price)
  end

  private

  # 売上金額計上
  def appropriation(price)
    @sales += price
  end
end

# Suicaクラスのインスタンスを作成
suica = Suica.new
# 「Suicaに任意の金額をチャージする」メソッドの呼び出し
suica.charge_preprocessing(100)
# 「現在のSuicaのチャージ残高を取得する」メソッドの呼び出し
suica.charge_balance

# Juiceクラスのインスタンスを作成
target_juice = Juice.new('ペプシ', 150)

# VendinMachineクラスのインスタンスを作成
vendinmachine = VendinMachine.new
# 「購入可否の判定」メソッドの呼び出し
vendinmachine.decide(target_juice)
# 「購入処理」メソッドの呼び出し
vendinmachine.buy(suica, target_juice)
# 「現在の売上金額を出力する」メソッドの呼び出し
vendinmachine.output_sales
# 「購入可能なドリンクリストを出力する」メソッドの呼び出し
vendinmachine.juice_list
# 「在庫を補充する」メソッドの呼び出し
vendinmachine.replenishment('いろはす', 120)
