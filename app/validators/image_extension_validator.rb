class ImageExtensionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ['.jpg', '.jpeg', '.png', '.gif'].include?(value.downcase)
      record.errors[attribute] << (options[:message] || "はJPEG、PNG、GIF形式のファイルのみです")
    end
  end
end
