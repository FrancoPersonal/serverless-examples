build:
	dep ensure
	env GOOS=linux go build -ldflags="-s -w" -o bin/aws-golang-dynamo-stream-to-elasticsearch cmd/aws-golang-dynamo-stream-to-elasticsearch/main.go

.PHONY: clean
clean:
	rm -rf ./bin ./vendor Gopkg.lock

.PHONY: deploy
deploy: clean build
	sls deploy --verbose
