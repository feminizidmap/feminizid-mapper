FROM ruby:3.0.1-slim-buster

RUN apt-get update \
        && apt-get install -qq -y build-essential libpq-dev \
        && mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

#RUN mkdir -p tmp/sockets
#RUN mkdir -p tmp/pids

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

CMD ["rails", "server", "-b", "0.0.0.0"]
#CMD ["puma", "-C", "config/puma.rb"]
