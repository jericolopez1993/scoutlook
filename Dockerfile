FROM ruby:2.3.1

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs

WORKDIR /pb-platform

COPY Gemfile /pb-platform/Gemfile
COPY Gemfile.lock /pb-platform/Gemfile.lock

RUN bundle install

COPY . /pb-platform
