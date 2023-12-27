# 標準入力格納配列
score = []
# ゴルフスコア格納配列
score__output = []
# 標準入力格納配列・ゴルフスコア格納配列カウント変数
score_point = 0

# 一部の各スコアをハッシュに格納する
SCORE_MAPPING = {
  -1 => 'ボギー',
  0 => 'パー',
  1 => 'バーディ',
  2 => 'イーグル',
  3 => 'アルバトロス',
  4 => 'コンドル',
}

# 標準入力を受け取り、「,」区切りで配列に格納する
# 打数
number_of_strokes = gets.chomp.split(',')
# 打罰数
number_of_penalty_strokes = gets.chomp.split(',')

# 「打数 - 打罰数」でスコア計算後、配列に格納する
# スコアを比較して該当する文字列を出力用配列に格納する
while score_point < 18
  number_of_strokes[score_point] = number_of_strokes[score_point].to_i
  number_of_penalty_strokes[score_point] = number_of_penalty_strokes[score_point].to_i
  score[score_point] = number_of_strokes[score_point] - number_of_penalty_strokes[score_point]

  # ハッシュに格納していない一部のスコアを配列に格納する
  if score[score_point] <= -2
    score__output[score_point] = score[score_point].abs.to_s + 'ボギー'
  elsif number_of_strokes[score_point] != 5 && number_of_penalty_strokes[score_point] == 1
    score__output[score_point] = 'ホールインワン'
  # ハッシュに格納した一部のスコアを配列に格納する
  else
    score__output[score_point] = SCORE_MAPPING[score[score_point]]
  end
  score_point += 1
end

# 該当するスコアの文字列を「,」区切りで出力する
puts score__output.join(',')
