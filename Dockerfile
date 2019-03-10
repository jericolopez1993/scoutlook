FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /scoutcrm

COPY Gemfile /scoutcrm/Gemfile
COPY Gemfile.lock /scoutcrm/Gemfile.lock

RUN bundle install

RUN  gem install mailcatcher -v 0.6.5

COPY . /scoutcrm
