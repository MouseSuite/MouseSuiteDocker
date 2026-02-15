tag=mousesuite
DockerFile=Dockerfile
all: main

main:
	@printf '\033[0;35m'"Building ${tag}"'\033[0m'"\n"
	docker build -f ${DockerFile} -t ${tag} .

fresh: 
	@printf '\033[0;35m'"Building fresh ${tag}"'\033[0m'"\n"
	docker build --no-cache -f ${DockerFile} -t ${tag} .

shell: #all
	@printf '\033[0;35m'"Launching interactive ${tag} session"'\033[0m'"\n"
	docker run -it --rm -v ${PWD}/out:/out --entrypoint bash ${tag}

gpushell:
	@printf '\033[0;35m'"Launching interactive ${tag} GPU session"'\033[0m'"\n"
	docker run  -it --rm -v${PWD}/bin:/opt/bin --runtime=nvidia --gpus all --entrypoint bash ${tag}

push:
	@printf '\033[0;35m'"Pushing to GitHub Container Registry"'\033[0m'"\n"
	docker build -f ${DockerFile} -t ghcr.io/MouseSuite/${tag} .
	docker push ghcr.io/MouseSuite/${tag}
