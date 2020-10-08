FROM fribbledom/beehive:latest

LABEL authors="Gabriel Alacchi: alacchi.g@gmail.com, Christian Muehlhaeuser: muesli@gmail.com, Jonathon Sisson: sisson.j@gmail.com"

# Uncomment to add additional scripting languages for CMD bee usage
# Added as a new layer intentionally
RUN apk update && \
    apk add --no-cache python2 python3 perl ruby lua php # whatever else you want

# Where the admin interface will be served from
ENV CANONICAL_URL=http://localhost:8181

# Expose the application port
EXPOSE 8181

# create a volume for the configuration persistence
VOLUME /conf

# This form of ENTRYPOINT allows the beehive process to catch signals from the `docker stop` command
ENTRYPOINT /go/bin/beehive -config /conf/beehive.conf -bind 0.0.0.0:8181 -canonicalurl ${CANONICAL_URL}
