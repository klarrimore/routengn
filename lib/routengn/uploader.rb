module RouteNGN
  module Uploader
    def self.included(model)
      model.class_eval do
        extend ClassMethods
      end
    end
  end

  module ClassMethods
    def upload(file, params = {})
      data, headers = Multipart::Post.prepare_query("title" => 'title', "uploaded_data" => File.new(file))
      puts data.inspect
      puts headers.inspect
      RouteNGN.connection.access_token.post("/upload#{base_url}", data, headers)
    end
  end
end