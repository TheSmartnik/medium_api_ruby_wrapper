class MediumApi
  class Post < Struct.new(:api, :id, :title, :content_format, :content, :tags, :canonical_url, :publish_status, :license, :notify_followers, :publication_id, keyword_init: true)
  end
end
