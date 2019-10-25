FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
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
