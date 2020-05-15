FROM ruby:2.5.1-slim
RUN apt-get update && apt-get install -qq -y --no-install-recommends \
    build-essential libpq-dev
RUN gem install bundler
ENV INSTALL_PATH /onebitbot
RUN mkdir -p $INSTALL_PATH
WORKDIR $INSTALL_PATH
COPY Gemfile ./
ENV BUNDLE_PATH /gems
COPY . .