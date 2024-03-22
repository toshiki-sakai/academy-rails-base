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

| name          | version |
| ------------- | ------- |
| Ruby          | 3.1.4   |
| Ruby on Rails | 7.0.4.2 |

### 導入済みgem

- [pry-rails](https://github.com/pry/pry-rails)
- [rspec-rails](https://github.com/rspec/rspec-rails)
- [factory_bot_rails](https://github.com/thoughtbot/factory_bot_rails)

### DBをGUIで操作したい時は

DBをGUIで操作したい場合、以下のようなツールがあります。
実務でもよく使われるため、インストールして今から使い方に慣れておきましょう。

※Macを使用している方は、Sequel Aceがおすすめです。

- [Sequel Pro](https://www.sequelpro.com/)
- [Sequel Ace](https://sequel-ace.com/)
- [dbeaver](https://dbeaver.io/)

### Debug方法

Railsのデバッグ方法としてrails consoleと debugger がよく利用される。
そのデバッグ方法を記述しておく。

#### rails console(rails c)の起動方法

1. アプリケーションのあるディレクトリで下記のコマンドを順にうつ。

```
docker compose exec web
rails c
```

2. rails consoleが起動するので、そこでデバッグを行える。

https://github.com/prum-jp/academy-rails-base/assets/54013280/e73d8bca-2280-4367-9702-fc3119ba226c

#### debuggerの利用方法

1. アプリケーションのあるディレクトリで下記のコマンドをうつ。（このウインドウにログが流れます）

```
 docker attach academy-rails-base-web-1
```

2. コードで検証したい箇所にdebugger を仕込む（コントローラのアクションの中など）
3. debugger を仕込んだ箇所が通るようにブラウザでアプリケーションを操作
4. 仕込んだ箇所でブラウザが止まるのを確認
5. 1.で開いたウインドウを確認。そこで変数の確認など、デバッグを行える。

https://github.com/prum-jp/academy-rails-base/assets/54013280/3767cf7f-d2be-415d-9ac6-a878b802dc32
