require "oembed"

module AcastHelpers
  def acast_twitter_player_url(url)
    url = URI.parse(url)
    url.path = "/$" + url.path
    url.query = "?ref=twitter"
    url.to_s
  end

  def acast_embed_large(url)
    acast_embed(url, maxheight: 166).html
  end

  def acast_embed_flash(url)
    acast_embed(url, maxheight: 81).html
  end

  def acast_embed(url, options = {})
    key = [url].concat(options.values).join('-')

    return embed_cache[key] if embed_cache[key].present?

    resource = provider.get(url, options)
    embed_cache[key] = resource
  end

  private

  def provider
    OEmbed::Provider.new("https://oembed.acast.com/v1/embed-player")
  end

  def embed_cache
    @_embed_cache ||= {}
  end

  def track_cache
    @_track_cache ||= {}
  end
end
