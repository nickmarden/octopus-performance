== Octopus Performance Degradation

This is an example show that Octopus degrades performance of simple associations.

== Set it up

We run in production mode to ensure that caching is on

$ RAILS_ENV=production bin/rake db:create db:migrate

== Run it ==

$ RAILS_ENV=production bin/rails runner script/profile.rb

```
--------------
Before Octopus
--------------

user.posts - 0 posts - user.posts
                          1.330M (± 9.4%) i/s -      6.591M
user.posts - 0 posts - user.posts.map(&:title)
                        550.101k (± 6.4%) i/s -      2.746M
user.posts - 100 posts - user.posts
                          1.287M (±10.8%) i/s -      6.369M
user.posts - 100 posts - user.posts.map(&:title)
                         18.984k (± 7.2%) i/s -     95.760k
           post.user    669.718k (± 7.9%) i/s -      3.326M
      post.user.name    491.113k (± 7.2%) i/s -      2.455M

-------------
After Octopus
-------------

user.posts - 0 posts - user.posts
                         94.017k (± 4.8%) i/s -    469.604k
user.posts - 0 posts - user.posts.map(&:title)
                         24.923k (± 3.6%) i/s -    125.001k
user.posts - 100 posts - user.posts
                         94.163k (± 6.6%) i/s -    472.860k
user.posts - 100 posts - user.posts.map(&:title)
                          9.891k (± 4.6%) i/s -     49.820k
           post.user     83.874k (± 4.8%) i/s -    421.668k
      post.user.name     77.479k (± 4.7%) i/s -    388.131k
```
