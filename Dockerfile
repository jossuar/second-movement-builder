FROM openresty/openresty:bookworm AS builder

ENV DEBIAN_FRONTEND noninteractive

# These should all be one big install,
# but the fly.io registry kept dying on big layer transfers...
# Possibly should just do a two stage build.

RUN apt-get update
RUN apt-get install -y --no-install-recommends git make patch
RUN apt-get install -y --no-install-recommends gcc-arm-none-eabi
RUN apt-get install -y --no-install-recommends libnewlib-arm-none-eabi
RUN apt-get install -y --no-install-recommends clang
RUN apt-get install -y --no-install-recommends llvm lld
RUN apt-get install -y --no-install-recommends nodejs
RUN apt-get install -y --no-install-recommends emscripten

RUN git clone https://github.com/joeycastillo/second-movement.git

WORKDIR second-movement/

RUN git submodule update --init

COPY *.patch ./
RUN for f in *.patch; do patch -p1 < "$f"; done

RUN emmake make 'BUILD=build-sim' BOARD=sensorwatch_red DISPLAY=custom
RUN make 'BUILD=build-sensorwatch_red_classic' BOARD=sensorwatch_red DISPLAY=classic
RUN make 'BUILD=build-sensorwatch_green_classic' BOARD=sensorwatch_green DISPLAY=classic
RUN make 'BUILD=build-sensorwatch_blue_classic' BOARD=sensorwatch_blue DISPLAY=classic
RUN make 'BUILD=build-sensorwatch_pro_classic' BOARD=sensorwatch_pro DISPLAY=classic
RUN make 'BUILD=build-sensorwatch_red_custom' BOARD=sensorwatch_red DISPLAY=custom
RUN make 'BUILD=build-sensorwatch_green_custom' BOARD=sensorwatch_green DISPLAY=custom
RUN make 'BUILD=build-sensorwatch_blue_custom' BOARD=sensorwatch_blue DISPLAY=custom
RUN make 'BUILD=build-sensorwatch_pro_custom' BOARD=sensorwatch_pro DISPLAY=custom

WORKDIR /
RUN mkdir /builds
RUN touch /builds/list.html
#RUN chown -R www-data:www-data /emcache
RUN chown -R www-data:www-data /builds
COPY nginx.conf /usr/local/openresty/nginx/conf/
COPY static static
#RUN sed -n '/#include/{s/#include "\(.*\).h"/  <option value="\1">\1<\/option>/;p}' Sensor-second-movement/movement_faces.h > static/available_faces.html
COPY ./generate-faces-html.sh ./
RUN ./generate-faces-html.sh > static/available_faces.html
RUN cd /second-movement && git rev-parse HEAD > /static/commit_hash
COPY templates templates
COPY code code
RUN sed -n -e '/#include/{s/#include "\(.*\).h"/  \1 = true,/;p}' -e '1i return {' -e ';$a }' second-movement/movement_faces.h > code/available_faces.lua
