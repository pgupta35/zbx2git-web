# Usage:
#
# docker build --force-rm -t zbx2git-web .
# docker run -d --name zbx2git-web -h zbx2git-web -p 8080:80 -v /opt/zbx2git/repository:/git zbx2git-web

FROM        alpine:latest
MAINTAINER  Sebastian YEPES <syepes@gmail.com>

ARG         APK_FLAGS_COMMON="-q"
ARG         APK_FLAGS_PERSISTANT="${APK_FLAGS_COMMON} --clean-protected --no-cache"
ARG         APK_FLAGS_DEV="${APK_FLAGS_COMMON} --no-cache"

ENV         LANG=en_US.UTF-8 \
            TERM=xterm

RUN         apk update && apk upgrade \
            && apk add ${APK_FLAGS_PERSISTANT} git cgit nginx highlight fcgiwrap spawn-fcgi \
            && rm /etc/nginx/conf.d/default.conf \
            && mkdir -p /run/nginx /var/cache/cgit \
            && rm -rf /var/cache/apk/* /tmp/*

ADD         rootfs/ /
RUN         chmod 755 /*.sh /usr/lib/cgit/filters/syntax-highlighting.sh


EXPOSE      80/TCP
CMD         ["/run.sh"]

HEALTHCHECK --interval=15s --timeout=3s --retries=3 CMD nc -vz localhost 80 || exit 1
