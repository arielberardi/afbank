# Docker container for running the app in Development

# syntax = docker/dockerfile:1
FROM registry.docker.com/library/ruby:3.3.0-slim

# Rails app lives here
WORKDIR /app

# Install packages needed to build gems
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential git libpq-dev libvips pkg-config \
    postgresql-client curl nodejs

ENV RAILS_ENV="development"

# Install application gems
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .

# Create an user to avoid using root
RUN useradd rails --create-home --shell /bin/bash && chown -R rails:rails /app
USER rails:rails

ENTRYPOINT ["./bin/docker-entrypoint"]
EXPOSE 3000

# Added -b 0.0.0.0 for case when using windows and WSL
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]
