docker_image=echo
blue=blue:3000
green=green:3000

build: version=$(shell date +%s) 
build:
	docker build . -t ${docker_image}:${version} --build-arg version=${version}
	@echo "✅ version: ${version}"

deploy: image=$(shell docker images -q ${docker_image}:${version})
deploy: 
	echo "check version: ${version} ${image} to deploy ${target}"
	@if [ "${image}" == "" ]; then\
		echo "❌ version: ${version} not found";\
		exit 1;\
	fi
	docker compose stop ${target}
	docker rmi ${docker_image}:${target}
	docker compose rm -f ${target}
	docker tag ${docker_image}:${version} ${docker_image}:${target}
	docker compose create ${target}
	docker compose start ${target}
	@echo "✅ ${target} version: ${version} is deployed"

balance:
	sed -e "s;%BLUE%;${blue};g" -e "s;%GREEN%;${green};g" nginx/nginx.template > nginx/nginx.conf
	docker exec -it balancer /bin/sh -c "nginx -s reload"
	@echo "✅ load balancer is ready"

blue:
	make deploy target=blue

green:
	make deploy target=green

blue-down:
	make balance blue="${blue} backup"

blue-up:
	make balance blue="${blue}"

green-down:
	make balance green="${green} backup"

green-up:
	make balance green="${green}"

deploy-blue:
	make blue-down
	make deploy target=blue
	make blue-up

deploy-green:
	make green-down
	make deploy target=green
	make green-up