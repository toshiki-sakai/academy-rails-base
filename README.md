## Railsプロジェクトベース

### 環境構築
- 以下は初回のみ実施

```
docker compose build --no-cache
docker compose run web rails db:create
```

- docker run

```
docker compose up -d
```

#### 以下URLにアクセスしサーバーが立ち上がればOK

- http://localhost:3000


### Railsコマンドを使いたい時は

```
docker compose exec web bash

// 以下の表示になればOK
myapp#
```

### バージョン情報

name|version
--|--
Ruby | 3.1.4
Ruby on Rails | 7.0.4.2

### 導入済みgem

- [pry-rails](https://github.com/pry/pry-rails)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)
