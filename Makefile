.PHONY: build install watch

build:
	bundle exec jekyll build

install:
	bundle install --path vendor/bundle

watch:
	bundle exec jekyll build --watch
