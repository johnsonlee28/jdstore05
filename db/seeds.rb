# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

u = User.new
u.email = "123@123.com"
u.password = "123123"
u.password_confirmation = "123123"
u.is_admin = true
u.save

Category.create(name: "数码")
Category.create(name: "家具")
Category.create(name: "服饰")
Category.create(name: "手工艺")


for i in 1..10 do
  Product.create!(title: "Product no.#{i}", description: "这是用seed建立的第#{i}产品", category_id: rand(1..4), quantity: rand(22..44)*34, price: rand(409..900)*34, image: open("http://qmart.pk/image/cache/MacBook%20Pro/Apple%20Macbook%20Pro%20MLL42%2013%E2%80%9D%20(2016)%20Space%20Gray%20%20%20%20/388052-laptopcomputers-apple-macbookpro13inchmll42lla-800x800.jpg"))
  puts("建立#{i}产品")
end
