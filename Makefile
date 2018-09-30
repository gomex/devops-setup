.PHONY: deploy install serve

GITBOOK := $(shell command -v ./node_modules/.bin/gitbook 2> /dev/null)

deploy: install
	sh ./scripts/publish_gitbook.sh

install:
	docker run --rm -v "$PWD:/gitbook" -p 4000:4000 billryan/gitbook yarn 
	docker run --rm -v "$PWD:/gitbook" -p 4000:4000 billryan/gitbook install

serve:
ifndef GITBOOK
	$(error "Gitbook is not available, please run 'make install' first")
else
	docker run --rm -v "$PWD:/gitbook" -p 4000:4000 billryan/gitbook serve
endif
