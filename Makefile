build:
	docker build -t ursetto/reprepro:bionic -t ursetto/reprepro:latest .
package:
	@# test packaging from ./deb to ./repo -- note we cannot just do /deb/* because no shell to expand
	mkdir -p ./deb ./repo ./gpg
	docker run -it --rm -v $$(pwd)/repo:/repo -v $$(pwd)/deb:/deb -v $$(pwd)/gpg:/root/.gnupg \
		ursetto/reprepro \
		sh -c 'reprepro includedeb bionic /deb/*'
	@# another option: mount ./deb under /repo/deb so host path == container path
	@# another option: use 'processincoming' verb (https://unix.stackexchange.com/a/419320)
nginx:
	@# serve repo on localhost:8088
	docker run --rm -v $$(pwd)/repo:/usr/share/nginx/html/repo:ro -p 8088:80 nginx
	@# echo 'deb [trusted=yes] http://10.0.2.2:8088/repo bionic main' > /etc/apt/sources.list.d/myrepo.list


# Note: reprepro does not keep old versions of a package. This may change some year
#       (https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=570623) but don't hold your breath.
