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
  Product.create!(title: "Product no.#{i}", description: "这是用seed建立的第#{i}产品", category_id: rand(1..4), quantity: rand(22..44)*34, price: rand(409..900)*34 )
  puts("建立#{i}产品")
end

for i in 1..10 do
  Photo.create!(product_id:"#{i}",avatar: open("https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1494473873065&di=e451a498d2d4254ab66d00e3dd023373&imgtype=0&src=http%3A%2F%2Fleiphone.qiniudn.com%2Fuploads%2Fnew%2Farticle%2Fpic%2F201505%2F555b4b908753b.jpg"))
  Photo.create!(product_id:"#{i}",avatar: open("http://www.laptopmag.com/images/uploads/ppress/44891/apple-macbook-pro-13-2016-nw-g02.jpg"))
  Photo.create!(product_id:"#{i}",avatar: open("http://cdn.cultofmac.com/wp-content/uploads/2016/11/MacBook-Pro-with-Touch-Bar-2-1-780x520.jpg"))
  Photo.create!(product_id:"#{i}",avatar: open("http://www.computershopper.com/var/ezwebin_site/storage/images/media/images/apple-macbook-pro-2016-front-angle/1295295-2-eng-US/apple-macbook-pro-2016-front-angle.jpg"))
  puts("上传#{i}号产品的图片")
end
