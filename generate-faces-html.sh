#!/bin/sh

cd second-movement
commit="$(git rev-parse HEAD)"

for category in clock complication demo io sensor settings; do
    echo "<h3>$category</h3>"
    for f in "watch-faces/$category"/*.h; do
        echo "<option data-category=\"$category\" data-url=\"https://github.com/joeycastillo/second-movement/blob/$commit/$f\" value=\"$(basename $f .h)\">$(basename $f _face.h)</option>"
    done
done

#generate json file
echo -n "[" > faces.json
for category in clock complication demo io sensor settings; do
    echo -n "{\"category\": \"$category\", \"faces\": [" >> faces.json
    for f in "watch-faces/$category"/*.h; do
        echo -n "\"$(basename $f .h)\"," >> faces.json
    done
    echo -n "]}," >> faces.json
done
echo -n "]" >> faces.json
