FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# curlコマンドでgoogle chrome、chrome driverをインストール
# apt-getコマンドでchromeと依存関係にある各種パッケージを追加
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client fonts-liberation libappindicator3-1 libasound2 libatk-bridge2.0-0 libatspi2.0-0 libgtk-3-0 libnspr4 libnss3 libx11-xcb1 libxss1 libxtst6 xdg-utils
RUN curl -O https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
RUN dpkg -i google-chrome-stable_current_amd64.deb
RUN curl -O https://chromedriver.storage.googleapis.com/2.31/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip

RUN mkdir /cooklog_v2
WORKDIR /cooklog_v2
COPY Gemfile /cooklog_v2/Gemfile
COPY Gemfile.lock /cooklog_v2/Gemfile.lock
RUN bundle install
COPY . /cooklog_v2

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
