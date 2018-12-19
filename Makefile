all: help

deploy: ## update posts to iberianpig.github.io
	bash -c "./deploy.sh"

TITLE=""
new_post: ## create new post with TITLE=awesome_title
	./new_post.sh ${TITLE}

up: ## build and serve site on http://localhost:1313
	hugo server --buildDrafts

help: ## show this messages
	@grep -E '^[a-zA-Z0-9_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
