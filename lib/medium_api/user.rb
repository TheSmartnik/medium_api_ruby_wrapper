class MediumApi
  class User < Struct.new(:api, :id, :username, :name, :url, :image_url, keyword_init: true)
    def publications
      api.user_publications(user_id: id)
    end

    def create_post(post_options)
      api.create_post(user_id: id, **post_options)
    end
  end
end
