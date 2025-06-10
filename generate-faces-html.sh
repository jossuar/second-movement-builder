#!/bin/bash

cd second-movement
commit="$(git rev-parse HEAD)"

for category in clock complication demo io sensor settings; do
    echo "<h3>$category</h3>"
    for f in "watch-faces/$category"/*.h; do
        echo "<option data-category=\"$category\" data-url=\"https://github.com/joeycastillo/second-movement/blob/$commit/$f\" value=\"$(basename $f .h)\">$(basename $f _face.h)</option>"
    done
done

#generate json file
echo -n "[" > /static/faces.json
for category in clock complication demo io sensor settings; do
    echo -n "{\"category\": \"$category\", \"faces\": [" >> /static/faces.json
    for f in "watch-faces/$category"/*.h; do
        echo -n "{\"face\": \"$(basename $f _face.h)\"," >> /static/faces.json
        doc=`sed -n '/#define\|#pragma/,${p;/#include/q}' < $f | sed '1d;$d;s/"/\\"/;s/\/*//;s/^[ ]*\*[ ]*$//;s/^[ ]*\* //;s/[ ]*\*\/[ ]*$//;/^$/d;'`
        doc=${doc//$'\n'/\\n}
        doc=${doc//\"/\\\"}
        echo -n "\"doc\": \"${doc}\"}," >> /static/faces.json
    done
    echo -n "]}," >> /static/faces.json
done
echo -n "]" >> /static/faces.json
