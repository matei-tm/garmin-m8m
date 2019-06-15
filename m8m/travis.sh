#!/bin/bash
# travis.sh script for CI integration

SDK_URL="https://developer.garmin.com/downloads/connect-iq/sdks/connectiq-sdk-lin-3.0.11-2019-4-30-cd45859.zip"
SDK_FILE="sdk.zip"
SDK_DIR="sdk"

PEM_FILE="/tmp/developer_key.pem"
DER_FILE="/tmp/developer_key.der"

###

wget -O "${SDK_FILE}" "${SDK_URL}"
unzip "${SDK_FILE}" "bin/*" -d "${SDK_DIR}"

openssl genrsa -out "${PEM_FILE}" 4096
openssl pkcs8 -topk8 -inform PEM -outform DER -in "${PEM_FILE}" -out "${DER_FILE}" -nocrypt

export MB_HOME="${SDK_DIR}"
export MB_PRIVATE_KEY="${DER_FILE}"

export

rm -f /home/travis/build/matei-tm/garmin-m8m/m8m/monkey.jungle
./mb_runner/mb_runner.sh package /home/travis/build/matei-tm/garmin-m8m/m8m/