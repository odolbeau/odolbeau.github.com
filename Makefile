install:
	bundle install --path vendor/bundle

build:
	bundle exec jekyll build

watch:
	bundle exec jekyll build --watch
