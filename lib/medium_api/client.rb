require 'httparty'

class MediumApi
  class Client
    include HTTParty

    CODE_TO_ERRORS_MAPPING = {
      400 => Errors::BadRequestError,
      401 => Errors::UnauthorizedError,
      403 => Errors::ForbiddenError
    }

    attr_reader :api_key

    base_uri "https://api.medium.com/v1"

    def initialize(api_key:)
      @api_key = api_key
      self.class.headers("Authorization" => "Bearer #{api_key}")
    end

    def me
      with_error_handling do
        self.class.get('/me')
      end
    end

    def user_publications(id)
      with_error_handling do
        self.class.get("/users/#{id}/publications")
      end
    end

    def publication_contributors(id)
      with_error_handling do
        self.class.get("/publications/#{id}/contributors")
      end
    end

    def create_user_post(id, post_attributes)
      with_error_handling do
        self.class.post("/users/#{id}/posts", body: post_attributes)
      end
    end

    def create_publication_post(id, post_attributes)
      with_error_handling do
        self.class.post("/publications/#{id}/posts", body: post_attributes)
      end
    end

    private

    def with_error_handling
      response = yield
      return response['data'] if response.success?

      error_message = response['errors'].first['message']
      error_class = CODE_TO_ERRORS_MAPPING[response.code]
      raise error_class, error_message
    end
  end
end
