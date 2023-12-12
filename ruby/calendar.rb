require 'optparse'
require 'date'

opt = OptionParser.new

begin
  def to_calendar(cal)

    # Dateオブジェクトを作成
    today = Date.today

    # オプション・引数がない場合今年・今月を取得する
    cal[0] = today.mon if cal[0].nil?

    # 日付取得変数
    input_day = cal[0].to_i

    # 月初日付・月末日付を取得
    first_day = Date.new(today.year, input_day)
    last_day = Date.new(today.year, input_day, -1)

    # 出力日付格納配列
    month_day = [*first_day.mday..last_day.mday]

    # 曜日の数値格納変数
    day_of_week_count = first_day.wday

    # 日付格納用変数
    week_day = []

    # 曜日格納用配列
    day_of_week = ['月', '火', '水', '木', '金', '土', '日']

    # 月・年出力用変数
    cal_month_year = ("#{cal[0]}月" + ' ' + today.year.to_s)

    # 出力用文字列格納配列
    output_display = []
    output_display[0] = day_of_week
    
    # 型変換用配列の添字カウンタ
    i_count = 0

    # 出力配列の添字カウンタ
    out_count = 0

    # 月の桁数により表示位置の調整
    case input_day
    when 1..9
      puts cal_month_year.rjust(13)
    when 10..12
      puts cal_month_year.rjust(14)
    end
    
    # 日付を配列に格納する
    month_day.each do |n|
      # 日付を対応する曜日の数値に格納する
      week_day[day_of_week_count - 1] = n
      # 配列の中身がnilの場合に半角スペースを代入する
      week_day[i_count] = ' ' if week_day[i_count].nil?
      # String型に変換して格納する値を2桁にする
      day_array = week_day[i_count].to_s
      week_day[i_count] = day_array.rjust(2, ' ')
      # それぞれの配列の添字をカウント
      day_of_week_count += 1
      i_count += 1
    end

    # 配列を1週間ごとに分割
    week_day = week_day.each_slice(7).to_a
    # 半角スーペースで結合して1週間ごとに出力する
    while out_count < week_day.length + 1
      output_display[out_count + 1] = week_day[out_count]
      puts output_display[out_count].join(' ')
      out_count += 1
    end

  end
  
  # optparseオブジェクトに-mオプションを登録する
  opt.on('-m'){
    to_calendar(ARGV)
  }
  
  # オプション・引数を指定しない場合のメソッド呼び出し
  if ARGV == []
    to_calendar(ARGV)
  end
  
  # parseすることで引数だけを取り出す
  opt.parse!(ARGV)
  
# -mの引数が不正な月の場合は下記の文言を出力
rescue => exception
  puts "22 is neither a month number (1..12) nor a name"
end
