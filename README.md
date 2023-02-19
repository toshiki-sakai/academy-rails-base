## Railsプロジェクトベース

### 環境構築
- （初回のみ）docker image build && db create

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

### バージョン情報

name|version
--|--
Ruby | 3.1.3
Ruby on Rails | 7.0.4.2