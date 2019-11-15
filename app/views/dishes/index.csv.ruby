require 'csv'

CSV.generate do |csv|
  # 1行目にラベルを追加
  csv_column_labels = %w(名前 説明 作った人 作り方参照用URL\
                         コツ・ポイント 所要時間[分] 人気度 分量[人分] 最初に作った日時\
                         材料1の名前 材料1の分量 材料2の名前 材料2の分量\
                         材料3の名前 材料3の分量 材料4の名前 材料4の分量\
                         材料5の名前 材料5の分量 材料6の名前 材料6の分量\
                         材料7の名前 材料7の分量 材料8の名前 材料8の分量\
                         材料9の名前 材料9の分量 材料10の名前 材料10の分量)
  csv << csv_column_labels
  # 各料理のカラム値を追加
  current_user.feed.each do |dish|
    # まず材料以外のカラムを追加
    csv_column_values = [
      dish.name,
      dish.description,
      dish.user.name,
      dish.reference,
      dish.tips,
      dish.required_time,
      dish.popularity,
      dish.portion,
      dish.created_at.strftime("%Y/%m/%d(%a)")
    ]
    # 材料の数(number_of_ingredients)を特定
    # 初期値を9にしておき、nameが空の材料が見つかったらその配列番号に置き換える
    number_of_ingredients = 9
    dish.ingredients.each_with_index do |ing, index|
      if ing.name.empty?
        number_of_ingredients = index
        break
      end
    end
    # 材料の数だけカラムを追加する
    i = 0
    while i <= number_of_ingredients
      csv_column_values.push(dish.ingredients[i].name, dish.ingredients[i].quantity)
      i += 1
    end
    # 最終的なcsv_column_valuesをcsvのセルに追加
    csv << csv_column_values
  end
end
