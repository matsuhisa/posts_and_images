# テキストの投稿と、画像の投稿

* Ruby on Rails 4.2
* Ruby 2.2

* テキスト
* 画像
 * 画像の保存はS3に行う
 * 画像投稿のgem は利用しない

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

# s3の設定
