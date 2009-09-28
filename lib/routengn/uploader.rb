module RouteNGN
  module Uploader
    def self.included(model)
      model.class_eval do
        extend ClassMethods
      end
    end
  end

  module ClassMethods
    def upload(file, opts = {})
      args = {:uploaded_data => File.new(file)}.merge! opts
      data, headers = HTTP::Multipart.prepare_query(args)
      RouteNGN.upload("/upload#{base_url}", data, headers)
    end
  end
end