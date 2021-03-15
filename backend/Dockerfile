FROM ruby:3.0.0-slim-stretch

RUN apt-get update \
        && apt-get install -qq -y build-essential libpq-dev \
        && mkdir -p /app

WORKDIR /app

COPY Gemfile Gemfile.lock ./

RUN bundle install

COPY . ./

EXPOSE 3000

ENTRYPOINT ["bundle", "exec"]

#CMD ["rails", "server", "-b", "0.0.0.0"]
CMD ["puma", "-C", "config/puma.rb"]
