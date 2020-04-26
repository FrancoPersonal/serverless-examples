VENV_DIR ?= .venv
VENV_ACT = . $(VENV_DIR)/bin/activate

usage:       ## Show this help
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

start:       ## Start LocalStack infrastructure
	@$(VENV_ACT); nohup localstack start &

install:     ## Install global dependencies
	which localstack || (virtualenv $(VENV_DIR); $(VENV_ACT); pip install -q localstack)
	docker pull localstack/localstack &
	npm install -q -s -g serverless serverless-localstack 2>&1 > /dev/null

test-all:    ## Run all tests
	(cd aws-golang-dynamo-stream-to-elasticsearch && make build && npm install serverless-localstack && make deploy)
	(cd aws-ffmpeg-layer && ./build.sh && npm install serverless-localstack && sls deploy)

.PHONY: usage install test-all
