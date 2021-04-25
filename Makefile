all: help

setup: ## clone public and setup
	git clone https://github.com/iberianpig/iberianpig.github.io public
	git clone https://github.com/iberianpig/hugo_theme_robust themes/hugo_theme_robust
deploy: ## update posts to iberianpig.github.io
	./deploy.sh

new_post: ## create new post
	./new_post.sh

watch: ## build and serve site on http://localhost:1313
	hugo server --buildDrafts --watch

help: ## show this messages
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
