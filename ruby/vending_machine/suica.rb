class Suica
  # Suicaのチャージ残高変数
  @@charge = 500

  # クラスメソッドの定義
  class << self
    # Suicaのチャージ残高参照
    def charge
      @@charge
    end

    # Suicaの現在のチャージ残高を出力する
    def charge_balance
      puts "Suicaのチャージ残高は#{@@charge}円です。"
    end

    # 「Suicaに任意の金額をチャージする」メソッドの呼び出し
    # Suicaのチャージ残高を直接外部から書き換えられないようにするための呼び出しメソッド
    def charge_preprocessing(price)
      self.charge = price
    end

    # 「Suicaのチャージ残高を減らす」メソッドの呼び出し
    def reduce_balance_preprocessing(price, number)
      reduce_balance(price, number)
    end

    private

    # Suicaに任意の金額をチャージする
    def charge=(price)
      if price < 100
        raise '100円以上の金額をチャージしてください。'
      else
        @@charge += price
      end
    end

    # Suicaのチャージ残高を減らす
    def reduce_balance(price, number)
      @@charge -= price * number
    end
  end
end
