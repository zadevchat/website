require "oembed"

module SoundCloudHelpers

  def soundcloud_embed_large(url)
    get(url, 166)
  end

  def soundcloud_embed_flash(url)
    get(url, 81)
  end

  def get(url, maxheight)
    key = [url, maxheight].join('-')

    return cache[key] if cache[key].present?

    resource = OEmbed::Providers::SoundCloud.get(url, maxheight: maxheight)
    cache[key] = resource.html
  end

  def cache
    @_cache ||= {}
  end

end
