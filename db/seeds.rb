# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Initialize Admin User
if User.find_by(email: "admin@test.com").nil?
  a = User.new
  a.email = "admin@test.com"           # 可以改成自己的 email
  a.name = "admin"
  a.password = "12345678"                # 最少要六码
  a.password_confirmation = "12345678"   # 最少要六码
  a.is_admin = true
  a.save
  puts "Admin 已经建立好了，帐号为#{a.email}, 密码为#{a.password}"
else
  puts "Admin 已经建立过了，脚本跳过该步骤。"
end

if User.find_by(email: "user@test.com").nil?
  u = User.new
  u.email = "user@test.com"           # 可以改成自己的 email
  u.name = "user"
  u.password = "12345678"                # 最少要六码
  u.password_confirmation = "12345678"   # 最少要六码
  u.is_admin = false
  u.save
  puts "User 已经建立好了，帐号为#{u.email}, 密码为#{u.password}"
else
  puts "User 已经建立过了，脚本跳过该步骤。"
end


# Initialize Product

Product.create!(title: "会员卡",
  description: "办理会员卡，期限内可获得使用Fitness各种器械，参与活动的资格",
  price: 2800,
  quantity: 5,
  category: "半年",
  image: open("http://ww4.sinaimg.cn/large/006tNbRwgy1ffvc7ldcjlj31kw151u19.jpg")
  )

Product.create!(title: "瑜伽课程",
  description: "专业瑜伽教练指导",
  price: 5000,
  quantity: 5,
  category: "半年",

  image: open("http://ww2.sinaimg.cn/large/006tNbRwgy1ffvc74wdslj31kw11xkjt.jpg")
  )

Product.create!(title: "一对一私教",
  description: "专业教练一对一指导，为你量身订制合适的健身计划",
  price: 7800,
  quantity: 5,
  category: "半年",

  image: open("http://ww3.sinaimg.cn/large/006tNbRwgy1ffvc79e1mqj31kw11x1l4.jpg")
  )
