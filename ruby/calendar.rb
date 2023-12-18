require 'optparse'
require 'date'

# optオブジェクトを作成
opt = OptionParser.new

# Dateオブジェクトを作成
today = Date.today
# 今月・今年格納変数
month = today.mon
year = today.year

# オプション・引数を指定した場合にその月を取得
unless ARGV[1].nil?
  month = ARGV[1].to_i
end

# -mの引数が不正な月の場合(1~12以外の場合)エラーを出力する
unless (1..12).cover?(month)
  raise "#{month} is neither a month number (1..12) nor a name"
end

# -mオプションを登録する
opt.on('-m')

# parseすることで引数だけを取り出す
opt.parse!(ARGV)

# カレンダー出力メソッド
def to_calendar(year, month)
  # 月初日付・月末日付を取得
  first_day = Date.new(year, month)
  last_day = Date.new(year, month, -1)

  # 出力日付格納配列
  month_day = [*first_day.mday..last_day.mday]

  # 曜日の数値格納変数
  day_of_week_count = 0

  # 曜日の数値格納変数(月曜始まりなため「-1」する)
  # 月初の日付が日曜日始まり(wdayが0の場合配列の位置を調整するために6を代入)
  # それ以外は月初の日付から「-1」した位置から日付を格納していく
  if first_day.wday.zero?
    day_of_week_count = 6
  else
    day_of_week_count = first_day.wday - 1
  end

  # 月・年出力
  puts ("#{month}月 #{year}").center(20)

  # 曜日出力
  puts '月 火 水 木 金 土 日'

  # 出力用文字列格納配列
  output_display = []

  # 出力配列の添字カウンタ
  out_count = 0

  # 日付を格納するまでの位置を半角スペースで埋める
  month_day.each do |day|
    if output_display == []
      while out_count < day_of_week_count
        output_display[out_count] = ' '
        printf("%2s\s", output_display[out_count])
        out_count += 1
      end
    end

    # 続きの位置から日付を格納する
    output_display[day_of_week_count] = day
    
    # 日付出力
    printf("%2s\s", output_display[day_of_week_count])

    # 1週間分の日付を格納後、改行する
    # 配列格納位置を0でリセット
    if day_of_week_count == 6
      puts "\n"
      day_of_week_count = 0
    elsif day_of_week_count < 6
      day_of_week_count += 1
    end
  end

  # 最後に出力されてしまう「%」を出力させないようにする
  unless day_of_week_count.zero?
    puts ""
  end
end

# カレンダー出力メソッド呼び出し
to_calendar(year, month)
