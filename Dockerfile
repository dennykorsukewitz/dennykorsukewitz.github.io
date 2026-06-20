FROM ruby:3.2-slim

ENV BUNDLE_PATH=/usr/local/bundle \
    JEKYLL_ENV=development

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    git \
    nodejs \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /srv/jekyll

COPY Gemfile ./
RUN bundle install

COPY docker/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

EXPOSE 4000 35729

ENTRYPOINT ["/entrypoint.sh"]
