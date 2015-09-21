matthew = User.create!(name: "Matthew")
raffi = User.create!(name: "Raffi")

100.times do |i|
  matthew.posts.create!(title: "Post #{i+1}", body: "words" * i)
end
