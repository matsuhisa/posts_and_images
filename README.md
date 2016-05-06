# テキストの投稿と、画像の投稿

* テキストと画像をアップロードする
* 画像
 * 画像の保存はS3に行う
 * 画像投稿のgem は利用しない

## 環境

* Ruby on Rails 4.2
* Ruby 2.2

# 目次

# scaffold

```
rails generate scaffold Post title:string description:text
rails generate scaffold Image file_name:string extension:string description:text
rails generate model PostImage post_id:integer image_id:integer
```

# routes

```routes.rb
resources :images
resources :posts do
  collection do
    post '/confirm', to: 'posts#confirm', as: :confirm
    get '/complete', to: 'posts#complete', as: :complete
  end
end
```

# association

```ruby
class Image < ActiveRecord::Base
  has_many :post_images
  has_many :posts, through: :post_images
end
```

```ruby
lass PostImage < ActiveRecord::Base
  belongs_to :post
  belongs_to :image
end
```

```ruby
class Post < ActiveRecord::Base
  has_many :post_images
  has_many :images, through: :post_images

  validates :title, presence: true
  validates :description, presence: true
end

```

# 独自の Validates

## config/application.rb

```ruby
config.autoload_paths += Dir["#{config.root}/app/validators"]
```

## app/validators/image_extension_validator.rb

```ruby
class ImageExtensionValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless ['.jpg', '.jpeg', '.png', '.gif'].include?(value.downcase)
      record.errors[attribute] << (options[:message] || "はJPEG、PNG、GIF形式のファイルのみです")
    end
  end
end
```

## Image モデル

```ruby
class Image < ActiveRecord::Base
  has_many :post_images
  has_many :posts, through: :post_images

  validates :extension, presence: true, image_extension: true

  attr_accessor :file
end
```

## 確認画面

# helper

```ruby
module ApplicationHelper
  def data_uri(file)
    base64 = Base64.encode64(file.upload_file.read).gsub(/\s+/, "")
    "data:#{file.upload_file.content_type};base64,#{Rack::Utils.escape(base64)}"
  end
end
```

## 完了画面

# その他

## gem :gem:

### quiet_assets

* quiet_assets は、assets のログを出さないためのもの

### aws-sdk

### dotenv-rails

# S3の設定

## .env

```
AWS_REGION=ap-northeast-1
AWS_ACCESS_KEY_ID=XXXXX
AWS_SECRET_ACCESS_KEY=XXXXX
S3_BUCKET=XXXXX
S3_URL=XXXXX
```

## Ruby で S3 を使う

```ruby
s3 = Aws::S3::Client.new
response = s3.list_buckets
puts response.buckets.map(&:name)
```

## S3バケットポリシーの設定

```json
{
  "Version": "2012-10-17",
  "Id": "Policy1462541770992",
  "Statement": [
    {
      "Sid": "Stmt1462541763410",
      "Effect": "Allow",
      "Principal": "*",
      "Action": "s3:*",
      "Resource": "arn:aws:s3:::static-rails/*"
    }
  ]
}
```
