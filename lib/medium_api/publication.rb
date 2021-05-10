module MediumApi
  class Publication < Struct.new(:id, :name, :description, ,:url, :image_url, :client)

    def contributors
      client.publications(publication_id: id)
    end

    def create_post(options)
      client.create_publication_post(publication_id: id, **options)
    end
  end
end
