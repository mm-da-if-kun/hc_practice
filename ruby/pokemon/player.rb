# Pokemonクラスを読み込む
require_relative './pokemon.rb'

class Player
  # モジュールをインクルードする
  include NameService

  # アクセサメソッドを定義
  attr_accessor :name

  def initialize
    @name = ''
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

  def trainer
    puts "ポケモントレーナーの#{@name}さんは今日から旅に出ます。"
  end
end
