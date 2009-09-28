module RouteNGN
  module Uploader
    def self.included(model)
      model.class_eval do
        extend ClassMethods
      end
    end
  end

  module ClassMethods
    def upload(file)
      data, headers = HTTP::Multipart.prepare_query("title" => "upload", "uploaded_data" => File.new(file))
      RouteNGN.upload("/upload#{base_url}", data, headers)
    end
  end
end