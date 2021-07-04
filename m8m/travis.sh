#!/bin/bash
# travis.sh script for CI integration

# https://github.com/4ch1m/mb_runner
# sdk list from: https://developer.garmin.com/downloads/connect-iq/sdks/sdks.json

SDK_URL="https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-lin-3.1.9-2020-06-24-1cc9d3a70.zip"

SDK_FILE="sdk.zip"
SDK_DIR="sdk"

PEM_FILE="/tmp/developer_key.pem"
DER_FILE="/tmp/developer_key.der"

###
rm -R "${SDK_DIR}"
wget -O "${SDK_FILE}" "${SDK_URL}"
unzip "${SDK_FILE}" "bin/*" -d "${SDK_DIR}"

openssl genrsa -out "${PEM_FILE}" 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in "${PEM_FILE}" -out "${DER_FILE}" -nocrypt

export MB_HOME="${SDK_DIR}"
export MB_PRIVATE_KEY="${DER_FILE}"

export

### patching file for downgraded sdk
\cp manifest.xml manifest.xml.bak
sed -i '/d2air/d' manifest.xml
sed -i '/descentmk2/d' manifest.xml
sed -i '/descentmk2s/d' manifest.xml
sed -i '/enduro/d' manifest.xml
sed -i '/fr55/d' manifest.xml
sed -i '/fr745/d' manifest.xml
sed -i '/fr945lte/d' manifest.xml
sed -i '/marqgolfer/d' manifest.xml
sed -i '/venu2/d' manifest.xml
sed -i '/venu2s/d' manifest.xml
sed -i '/venusq/d' manifest.xml
sed -i '/venud/d' manifest.xml
sed -i '/venusqm/d' manifest.xml

./mb_runner/mb_runner.sh package /home/travis/build/matei-tm/garmin-m8m/m8m/
\cp manifest.xml.bak manifest.xml
rm manifest.xml.bak
echo Completed the packages build process
