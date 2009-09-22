module RouteNGN
  module Uploader
    def self.included(model)
      model.class_eval do
        extend ClassMethods
      end
    end
  end

  module ClassMethods
    def upload
      # STUB
      puts "data, headers = Multipart::Post.prepare_query(\"title\" => 'title', \"uploaded_data\" => File.new(path))"  
    end
  end
end