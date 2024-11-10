FROM ruby:3.1.4

# 必要なディレクトリ作成
RUN mkdir /myapp
WORKDIR /myapp

# GemfileとGemfile.lockをコピー
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock

# システムパッケージの更新とNode.jsのインストール
RUN apt-get update -qq && apt-get install -y \
  nodejs \
  npm \
  && apt-get clean \
  && rm -rf /var/lib/apt/lists/*

# Gem関連のアップデート
RUN gem update --system
RUN bundle update --bundler

# 必要なGemをインストール
RUN bundle install

# アプリケーションコードをコピー
COPY . /myapp

# エントリポイントスクリプトを設定
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Railsサーバー用のポートを公開
EXPOSE 3000

# メインプロセスを開始
CMD ["rails", "server", "-b", "0.0.0.0"]
