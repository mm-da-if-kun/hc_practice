require_relative './vendin_machine.rb'

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
