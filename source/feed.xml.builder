xml.instruct!
xml.feed "xmlns" => "http://www.w3.org/2005/Atom" do
  site_url = "http://zadevchat.io/"
  xml.title "The ZADevChat Podcast"
  xml.subtitle "A weekly panel discussion with topics around the South African software developer community."
  xml.id URI.join(site_url)
  xml.link "href" => URI.join(site_url)
  xml.link "href" => URI.join(site_url, current_page.path), "rel" => "self"

  episodes = blog('podcast').articles
  articles = blog('blog').articles
  combined = [ episodes[0..5], articles[0..5] ].flatten.compact.sort_by(&:date).reverse

  xml.updated(combined.first.date.to_time.iso8601)
  xml.author { xml.name "ZADevChat" }

  combined[0..5].each do |article|
    xml.entry do
      xml.title article.title
      xml.link "rel" => "alternate", "href" => URI.join(site_url, article.url)
      xml.id URI.join(site_url, article.url)
      xml.published article.date.to_time.iso8601
      xml.updated File.mtime(article.source_file).iso8601
      xml.author { xml.name "ZADevChat" }
      # xml.summary article.summary, "type" => "html"
      xml.content article.body, "type" => "html"
    end
  end
end
