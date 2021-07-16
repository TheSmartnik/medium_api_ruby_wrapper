class MediumApi
  class Publication < Struct.new(:api, :id, :name, :description, :url, :image_url, keyword_init: true)

    def contributors
      api.publication_contributors(publication_id: id)
    end

    def create_post(post_attributes)
      api.create_publication_post(publication_id: id, **post_attributes)
    end
  end
end
