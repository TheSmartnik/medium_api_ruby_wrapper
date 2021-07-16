class MediumApi
  class Contributor < Struct.new(:api, :user_id, :publication_id, :role, keyword_init: true)
  end
end
