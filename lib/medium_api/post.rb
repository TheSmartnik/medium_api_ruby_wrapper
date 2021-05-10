module MediumApi
  class Post < Struct.new(:id, :title, :content_format, :content, :tags, :  , :publish_status, :license, :notify_followers)
  end
end
