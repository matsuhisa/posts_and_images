module ApplicationHelper
  def data_uri(file)
    base64 = Base64.encode64(file.upload_file.read).gsub(/\s+/, "")
    "data:#{file.upload_file.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
