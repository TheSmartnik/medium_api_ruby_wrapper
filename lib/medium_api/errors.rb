class MediumApi
  module Errors
    class Error < StandardError; end

    class BadRequestError < Error; end
    class UnauthorizedError < Error; end
    class ForbiddenError < Error; end


  end
end
