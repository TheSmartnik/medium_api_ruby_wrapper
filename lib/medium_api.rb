require "medium_api/version"
require "medium_api/utils"
require "medium_api/errors"
require "medium_api/client"
require "medium_api/user"
require "medium_api/post"
require "medium_api/publication"
require "medium_api/contributor"

class MediumApi
  attr_reader :client

  def initialize(api_key:)
    @client = Client.new(api_key: api_key)
  end

  def me
    attributes = client.me

    User.new(api: self, **Utils.underscore_keys(attributes))
  end

  def user_publications(user_id:)
    attributes_array = client.user_publications(user_id)

    attributes_array.map do |attributes|
      Publication.new(api: self, **Utils.underscore_keys(attributes))
    end
  end

  def publication_contributors(publication_id:)
    contributors = client.publication_contributors(publication_id)
    contributors.map do |attributes|
      Contributor.new(api: self, **Utils.underscore_keys(attributes))
    end
  end

  def create_post(title:, content_format:, content:, user_id: nil, publication_id: nil, **optional_attributes)
    raise ArgumentError, "Both user_id and publication_id are supplicated. Please, provide only one" if user_id && publication_id
    raise ArgumentError, "user_id or publication_id is required" if user_id.nil? && publication_id.nil?

    post_options = optional_attributes.merge(title: title, content: content, content_format: content_format)

    created_post = if user_id
      client.create_user_post(user_id, Utils.camelize_keys(post_options))
    else
      client.create_publication_post(publication_id, Utils.camelize_keys(post_options))
    end

    Post.new(api:self, **created_post)
  end
end
