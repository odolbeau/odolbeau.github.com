.PHONY: build deploy install watch
.DEFAULT_GOAL: install

deploy: install build
	scp -r _site/* sd67004-deploy:/space/products/blog/

build:
	rm -R ./_site || true
	bundle exec jekyll build

install:
	bundle install --path vendor/bundle

watch:
	bundle exec jekyll build --watch
