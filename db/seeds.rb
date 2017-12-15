puts "Start seed"

xlsx = Roo::Excelx.new('public/1.xlsx')
xlsx.default_sheet = xlsx.sheets[0]

start_row = 1
end_row = 56
@resault = []

(start_row..end_row).each do |line|
  @resault.push(xlsx.row(line))
end

@revenue = @resault.shift
@revenue.shift

@resault.each do |good|
  name = good.shift
  @good = Good.find_or_create_by(title: name)
  good.each_with_index do |cell, index|
    date = @revenue[index]
    Sale.find_or_create_by(date: date, income: cell, good_id: @good.id)
  end
end
puts "Finish seed"