# module
# インタフェースの代わりにモジュールで代用
module NameService
  def change_name(new_name)
    # オーバーライドしない場合にエラーを発生させる
    raise "#{self.class}クラスで#{__method__}メソッドが定義されていません。"
  end

  def get_name
    # オーバーライドしない場合にエラーを発生させる
    raise "#{self.class}クラスで#{__method__}メソッドが定義されていません。"
  end
end

# class
# 抽象クラスのの代用としてオーバーライドするメソッドに「raise」を定義
class Pokemon
  # モジュールをインクルードする
  include NameService

  # アクセサメソッドを定義
  # カプセル化のため名前のみpraivateで定義
  attr_reader :type1, :type2, :hit_point
  private attr_accessor :name

  def initialize(type1, type2, hit_point)
    @name = ''
    @type1 = type1
    @type2 = type2
    @hit_point = hit_point
    # オーバーライドしない場合にエラーを発生させる
    raise "#{self.class}クラスで#{__method__}メソッドが定義されていません。"
  end

  def attack
    # オーバーライドしない場合にエラーを発生させる
    raise "#{self.class}クラスで#{__method__}メソッドが定義されていません。"
  end

  # NameServiceモジュールで定義されたメソッドをオーバーライド
  def change_name(new_name)
    if new_name == 'うんこ'
      puts '不適切な名前です。'
    elsif new_name != 'うんこ'
      self.name = new_name
    end
  end

  def get_name
    self.name
  end
end

class Pikachu < Pokemon
  # アクセサメソッドを定義
  attr_reader :type1, :type2, :hit_point

  # Pokemonクラスで定義されたメソッドをオーバーライド
  def initialize(type1, type2, hit_point)
    @type1 = type1
    @type2 = type2
    @hit_point = hit_point
  end

  def attack
    puts "#{Pokemon.instance_method(:get_name).bind(self).call}の10万ボルト!"
  end
end
