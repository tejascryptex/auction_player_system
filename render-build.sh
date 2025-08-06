#!/usr/bin/env bash


set -o errexit

# Install dependencies
bundle install
yarn install --check-files

# Compile assets (especially for Tailwind CSS)
RAILS_ENV=production bundle exec rails assets:precompile

# Run migrations
bundle exec rails db:migrate
