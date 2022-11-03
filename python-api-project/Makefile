APP_NAME="python-api-project"
IMAGE_NAME="eduardomatoss/python-api-project"
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Linux)
    DOCKER_USER=$(shell id -u $(USER)):$(shell id -g $(USER))
endif
ifeq ($(UNAME_S),Darwin)
    DOCKER_USER=
endif

local/install: generate-default-env-file
	poetry install

local/test:
	poetry run pytest -s -c tests/pytest.ini --pyargs ./tests -v -s --cov-report=html --cov-report=term --cov ./app

local/lint:
	poetry run flake8 app/
	poetry run black app/

local/run:
	poetry run python run.py

docker/build: generate-default-env-file
	CURRENT_UID=${DOCKER_USER} docker-compose build ${APP_NAME}

docker/up:
	CURRENT_UID=${DOCKER_USER} docker-compose up -d

docker/down:
	CURRENT_UID=${DOCKER_USER} docker-compose down --remove-orphans

docker/test:
	CURRENT_UID=${DOCKER_USER} docker-compose run ${APP_NAME} poetry run pytest -s -c tests/pytest.ini --pyargs ./tests -v -s --cov-report=html --cov-report=term --cov ./app

docker/lint:
	CURRENT_UID=${DOCKER_USER} docker-compose run ${APP_NAME} poetry run flake8 app/
	CURRENT_UID=${DOCKER_USER} docker-compose run ${APP_NAME} poetry run black app/

docker/bandit:
	CURRENT_UID=${DOCKER_USER} docker-compose run ${APP_NAME} poetry run bandit -r . app *.py

docker/verify:
	make docker/lint
	make docker/bandit

docker/run:
	CURRENT_UID=${DOCKER_USER} docker-compose run --service-port ${APP_NAME} poetry run python run.py

docker/migrations/generate:
	CURRENT_UID=${DOCKER_USER} docker-compose run ${APP_NAME} poetry run alembic revision --autogenerate

docker/migrations/upgrade:
	CURRENT_UID=${DOCKER_USER} docker-compose run ${APP_NAME} poetry run alembic upgrade head

image/build:
	docker build . --target production -t ${IMAGE_NAME}:${VERSION}

image/push:
	docker push ${IMAGE_NAME}:${VERSION}

generate-default-env-file:
	@if [ ! -f .env ]; then cp env.template .env; fi;
