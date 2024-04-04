FROM openresty/openresty:1.25.3.1-2-alpine
MAINTAINER Heiko Voigt <heiko.voigt@jimdo.com>

ENV \
 SESSION_VERSION=4.0.5 \
 HTTP_VERSION=0.17.2 \
 OPENIDC_VERSION=1.7.6 \
 JWT_VERSION=0.2.3 \
 FFI_ZLIB_VERSION=0.6 \
 OPENSSL_VERSION=1.2.1

RUN \
 apk update && apk upgrade && apk add curl && \
 cd /tmp && \
 curl -sSL https://github.com/bungle/lua-resty-session/archive/v${SESSION_VERSION}.tar.gz | tar xz && \
 curl -sSL https://github.com/pintsized/lua-resty-http/archive/v${HTTP_VERSION}.tar.gz | tar xz  && \
 curl -sSL https://github.com/pingidentity/lua-resty-openidc/archive/v${OPENIDC_VERSION}.tar.gz | tar xz && \
 curl -sSL https://github.com/cdbattags/lua-resty-jwt/archive/v${JWT_VERSION}.tar.gz | tar xz && \
 curl -sSL https://github.com/hamishforbes/lua-ffi-zlib/archive/v${FFI_ZLIB_VERSION}.tar.gz | tar xz && \
 curl -sSL https://github.com/fffonion/lua-resty-openssl/archive/${OPENSSL_VERSION}.tar.gz | tar xz && \
 cp -r /tmp/lua-resty-session-${SESSION_VERSION}/lib/resty/* /usr/local/openresty/lualib/resty/ && \
 cp -r /tmp/lua-resty-http-${HTTP_VERSION}/lib/resty/* /usr/local/openresty/lualib/resty/ && \
 cp -r /tmp/lua-resty-openidc-${OPENIDC_VERSION}/lib/resty/* /usr/local/openresty/lualib/resty/ && \
 cp -r /tmp/lua-resty-jwt-${JWT_VERSION}/lib/resty/* /usr/local/openresty/lualib/resty/ && \
 cp -r /tmp/lua-ffi-zlib-${FFI_ZLIB_VERSION}/lib/* /usr/local/openresty/lualib/ && \
 cp -r /tmp/lua-resty-openssl-${OPENSSL_VERSION}/lib/resty/* /usr/local/openresty/lualib/resty/ && \
 rm -rf /tmp/* && \
 mkdir -p /usr/local/openresty/nginx/conf/hostsites/ && \
 true

#COPY bootstrap.sh /usr/local/openresty/bootstrap.sh
COPY nginx /usr/local/openresty/nginx/

#ENTRYPOINT ["/usr/local/openresty/bootstrap.sh"]
