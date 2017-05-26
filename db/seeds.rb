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
  a.nickname = "admin"
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
  u.nickname = "user"
  u.password = "12345678"                # 最少要六码
  u.password_confirmation = "12345678"   # 最少要六码
  u.is_admin = false
  u.save
  puts "User 已经建立好了，帐号为#{u.email}, 密码为#{u.password}"
else
  puts "User 已经建立过了，脚本跳过该步骤。"
end


# Initialize Product

Product.create!(title: "一年会员卡",
  description: "
  本卡可在一年的有效时期内不限时、不限次，任意进行训练，
  享受每周各时段开课的训练课程，
  营养餐吧全天候提供健康美食、免费提供营养餐指导，
  免费享受软水沐浴、干湿蒸、网上冲浪，
  免费享受VIP贵重物品保管服务，
  免费得到巡场教练健身指导。
",
  price: 2800,
  quantity: 100,
  image: open("http://ww3.sinaimg.cn/large/006tNbRwgy1ffvn7s8i3hj31kw11x7wr.jpg")
  )

Product.create!(title: "瑜伽课程",
  description: "瑜伽是通过调息呼吸、动静平衡、身心统一等要诀来刺激身体恢复本身的自觉与自愈，改变人体的亚健康状态。它主要通过各种呼吸及各种不同的独特姿势给予头脑、筋肉、内脏、神经、荷尔蒙等适度的刺激，除去身体不安定因素，从而令身心达到健康自然统一安定的目的。",
  price: 5000,
  quantity: 45,

  image: open("http://ww2.sinaimg.cn/large/006tNbRwgy1ffvc74wdslj31kw11xkjt.jpg")
  )

Product.create!(title: "一对一私人教练",
  description: " 私人健身教练进行的是一对一的工作，工作具有互动性、针对性等特点。私人教练适合不同健康水平、年龄段和经济收入的人群，通过提供个性化的健身计划和关注，服务于健身顾客",
  price: 8800,
  quantity: 35,

  image: open("http://ww3.sinaimg.cn/large/006tNbRwgy1ffvc79e1mqj31kw11x1l4.jpg")
  )

Product.create!(title: "踏板操",
  description: "踏板操是在健美操的基础上加入踏板，增加了一些特殊的锻炼效果，其基本运动形式类似于上下台阶。
  特点与功效：运动负荷的可控性，安全性好；动作多变，娱乐性强。大量消耗能量，增进心肺功能；培养良好的方位感；对腿和臀部的塑性作用。",
  price: 2800,
  quantity: 15,

  image: open("http://ww4.sinaimg.cn/large/006tNbRwgy1ffvo445qy4j31kw11snmy.jpg")
  )
Product.create!(title: "形体训练",
  description: " 形体训练是吸收了健美操的一些教学方法和特点，以舞蹈和体操动作为素材，为达到健身修形的目的而进行的成套动作为主的练习方式。
  特点与功效：运动强度适中；注重身体动作感觉的培养；强调动作与音乐的和谐统一。达到修饰和锻炼身体局部的作用；培养良好的气质风度，提高生活和工作质量；使学员充分抒发美的感受
  ",
  price: 3500,
  quantity:25,

  image: open("http://ww2.sinaimg.cn/large/006tNbRwgy1ffvo5m2jo1j31kw24ikdy.jpg")
  )

Product.create!(title: "功率自行车",
  description: "功率自行车是当今世界上最流行的健身项目之一，它的发明者詹尼模拟的是两个基本地形：平地和山丘。当平地骑着功率自行车时使有很小的阻力，模拟山丘时要增加阻力。每一种模拟地形都有两个基本姿势：坐式和站式。
  特点与功效：简单易学，急具挑战性，强度可控制，冲破阻力时的成就令人兴奋不已。增强体质，提高心肺功能，去脂减肥，对下肢的锻炼更为集中。",
  price: 6800,
  quantity: 5,

  image: open("http://ww3.sinaimg.cn/large/006tNbRwgy1ffvnjmreprj31kw11vb2c.jpg")
  )
