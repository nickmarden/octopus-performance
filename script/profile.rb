require 'benchmark/ips'

Post.delete_all
User.delete_all

matthew = User.create!(name: "Matthew")
raffi = User.create!(name: "Raffi")

100.times do |i|
  matthew.posts.create!(title: "Post #{i+1}", body: "words" * i)
end

def run_benchmark
  matthew = User.find_by!(name: "Matthew")
  raffi = User.find_by!(name: "Raffi")

  # make sure posts are loaded
  raffi.posts.map(&:id)
  matthew.posts.map(&:id)

  # grab one post, and make the user is loaded
  post = Post.first
  post.user.id

  Benchmark.ips do |x|
    x.report("user.posts - 0 posts - user.posts") do |times|
      times.times do
        raffi.posts
      end
    end

    x.report("user.posts - 0 posts - user.posts.map(&:title)") do |times|
      times.times do
        raffi.posts.map(&:title)
      end
    end

    x.report("user.posts - 100 posts - user.posts") do |times|
      times.times do
        matthew.posts
      end
    end

    x.report("user.posts - 100 posts - user.posts.map(&:title)") do |times|
      times.times do
        matthew.posts.map(&:title)
      end
    end

    x.report("post.user") do |times|
      times.times do
        post.user
      end
    end

    x.report("post.user.name") do |times|
      times.times do
        post.user.name
      end
    end
  end
end

puts "Before Octopus"
run_benchmark

# now load octopus
require 'octopus'

puts "After Octopus"
run_benchmark
