# frozen_string_literal: true

source "https://rubygems.org"

gem "jekyll-theme-chirpy", "~> 7.1", ">= 7.1.1"

gem "html-proofer", "~> 5.0", group: :test

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

# gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
gem 'jekyll-notion'

# Fetching files easily
#gem 'open-uri'

# if you are going to use responsive images plugin
group :jekyll_plugins do
  # ...

  # github.com/rbuchberger/jekyll_picture_tag
  #gem 'jekyll_picture_tag', '2.0.4'
gem 'jekyll-fetch-notion'
end