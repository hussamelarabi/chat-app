FROM ruby:2.7.0
RUN apt-get update -qq 

RUN gem install rails -v '5.2.6'
RUN gem update bundler

# Define mountable directories.
VOLUME /root/chat_app
WORKDIR /root/chat_app

COPY Gemfile /root/chat_app/Gemfile
COPY Gemfile.lock /root/chat_app/Gemfile.lock

COPY wait-for-it.sh /root/chat_app/wait-for-it.sh


RUN bundle install

EXPOSE 3000
WORKDIR /root/chat_app

# Start the main process.
CMD ["entrypoint.sh"]
