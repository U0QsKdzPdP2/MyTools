# encoding: utf-8

# 事前に抜き出したSQLファイルに対し、
# どのテーブル（またはビュー）を参照しているかの関連図を作成するための元ネタを抽出するためのスクリプト

# 使用方法：ruby analysis_A.rb {SQLファイルのあるフォルダ}


require 'kconv'
require 'csv'

$tableViews = [

  "tableA",
  "tableB",
  "tableC",
  "ViewA"
]


#
#=== メイン関数
#
def main

  Dir::entries(ARGV[0]).each do |file|

    next if ((file == ".") or (file == ".."))

    # クエリを読み込む
    text = open(ARGV[0] + "\\" + file).read.toutf8.upcase

    # クエリが参照しているテーブル・ビューを抽出する
    list = $tableViews.select { |x| text.include?(x.upcase) }

    # 関連図作成用のための情報を出力する
    list.each { |x| print (file.toutf8 + "\t" + x + "\n") }
  end
end

main
