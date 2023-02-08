#
# Our Middleman configuration file
#

set :url_root, "https://zadevchat.io"

Time.zone = "Africa/Johannesburg"

###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions


# Generic blog
activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "blog"
  blog.name = "blog"

  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  blog.layout = "post"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  # blog.tag_template = "tag.html"
  # blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

# Episode blog
activate :blog do |blog|
  blog.name = "podcast"
  blog.sources = "podcast/{episode}.html"
  blog.permalink = "{episode}.html"
  blog.layout = "podcast"

  # Enable pagination
  blog.paginate = true
  blog.per_page = 10
  blog.page_link = "page/{num}"
end

activate :plaintext do |c|
  c.layout = "shownotes.text"
  c.handle_file = lambda do |resource|
    resource.path.start_with?("podcast/") && resource.path.end_with?(".html")
  end
end

page "/feed.xml", layout: false

# Reload the browser automatically whenever files change
configure :development do
  activate :livereload
end

# Nice URL's
activate :directory_indexes

# Be discoverable
activate :search_engine_sitemap

# Disqus
activate :disqus do |d|
  # Disqus shotname, without '.disqus.com' on the end (default = nil)
  d.shortname = 'zadevchat'
end

# Static CSS
activate :external_pipeline,
         name: :gulp,
         command: "yarn run #{build? ? 'build' : 'dev'}",
         source: "tmp"


###
# Helpers
###

# Methods defined in the helpers block are available in templates
# helpers do
#   def some_helper
#     "Helping"
#   end
# end

helpers do

  def root_url
    config[:root_url]
  end

  def image_url(source)
    parts = [root_url, image_path(source)].compact
    URI.join(*parts)
  end

end

require "lib/acast_helpers"
helpers AcastHelpers

require "lib/pick_helpers"
helpers PickHelpers

set :markdown_engine, :redcarpet
set :markdown, :tables => true, :autolink => true

# Build-specific configuration
configure :build do
  activate :asset_hash
  activate :minify_css
  activate :minify_javascript
end
