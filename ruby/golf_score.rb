# 標準入力格納配列
score = []
# ゴルフスコア格納配列
score__output = []
# 標準入力格納配列カウント変数
score_point = 0
# ゴルフスコア格納配列カウント変数
score_count = 0

# 標準入力を受け取り、「,」区切りで配列に格納する
# 打数
number_of_strokes = gets.chomp.split(',')
# 打罰数
number_of_penalty_strokes = gets.chomp.split(',')

# 「打数 - 打罰数」でスコア計算後、配列に格納する
while score_point < 18
  number_of_strokes[score_point] = number_of_strokes[score_point].to_i
  number_of_penalty_strokes[score_point] = number_of_penalty_strokes[score_point].to_i
  score[score_point] = number_of_strokes[score_point] - number_of_penalty_strokes[score_point]
  score_point += 1
end

# スコアを比較して該当する文字列を出力用配列に格納する
while score_count < score.length
  if score[score_count] == -1
    score__output[score_count] = 'ボギー'
  elsif score[score_count] <= -2
    score__output[score_count] = score[score_count].abs.to_s + 'ボギー'
  elsif score[score_count].zero?
    score__output[score_count] = 'パー'
  elsif score[score_count] == 1
    score__output[score_count] = 'バーディ'
  elsif score[score_count] == 2
    if number_of_penalty_strokes[score_count] == 1
      score__output[score_count] = 'ホールインワン'
    else
      score__output[score_count] = 'イーグル'
    end
  elsif score[score_count] == 3
    if number_of_strokes[score_count] == 4 && number_of_penalty_strokes[score_count] == 1
      score__output[score_count] = 'ホールインワン'
    elsif number_of_strokes[score_count] == 5 && number_of_penalty_strokes[score_count] == 2
      score__output[score_count] = 'アルバトロス'
    end
  elsif score[score_count] == 4
    if number_of_strokes[score_count] == 5 && number_of_penalty_strokes[score_count] == 1
      score__output[score_count] = 'コンドル'
    end
  end
  score_count += 1
end

# 該当するスコアの文字列を「,」区切りで出力する
puts score__output.join(',')
