# Pokemonクラス、Playerクラスを詠み込む
require_relative './pokemon.rb'
require_relative './player.rb'

# Pikachuクラスのインスタンスを作成
pika = Pikachu.new('でんき', '', 100)
pika.change_name('ピカチュウ')
pika.get_name
pika.attack

# Playerクラスのインスタンスを作成
player = Player.new
player.change_name('セレナ')
player.get_name
player.trainer
