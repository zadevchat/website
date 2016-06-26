require "oembed"
require "soundcloud"

module SoundCloudHelpers

  def soundcloud_embed_large(url)
    embed(url, maxheight: 166).html
  end

  def soundcloud_embed_flash(url)
    embed(url, maxheight: 81).html
  end

  def soundcloud_twitter_player_url(url)
    sound = track(url)
    uri = URI.escape(sound.uri, ":/")

    "https://w.soundcloud.com/player/?url=#{uri}&auto_play=false&show_artwork=true&visual=true&origin=twitter"
  end

  def embed(url, options = {})
    key = [url].concat(options.values).join('-')

    return embed_cache[key] if embed_cache[key].present?

    resource = OEmbed::Providers::SoundCloud.get(url, options)
    embed_cache[key] = resource
  end

  def track(url)
    return track_cache[url] if track_cache[url].present?
    track_cache[url] = client.get("/resolve", url: url)
  end

  private

  def client
    Soundcloud.new(client_id: ENV["SOUNDCLOUD_CLIENT_ID"])
  end

  def embed_cache
    @_embed_cache ||= {}
  end

  def track_cache
    @_track_cache ||= {}
  end

end
