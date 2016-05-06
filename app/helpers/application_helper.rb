module ApplicationHelper
  def data_uri(file)
    base64 = Base64.encode64(file.upload_file.read).gsub(/\s+/, "")
    "data:#{file.upload_file.content_type};base64,#{Rack::Utils.escape(base64)}"
  end

  def s3_url(file_name)
    "#{ENV['S3_URL']}/#{ENV['S3_BUCKET']}/#{file_name}"
  end
end
