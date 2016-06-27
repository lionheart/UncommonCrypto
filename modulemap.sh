#!/bin/sh
# Used with modifications from https://github.com/sgl0v/SCrypto
#
# The MIT License
#
# Copyright (c) 2010-2016 Maksym Shcheglov
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.

if [ "$#" -eq 2 ]; then
    SDKS=( $1 )
    BASE_DIR=$2
else
    SDKS=( iphoneos iphonesimulator macosx watchsimulator appletvsimulator)
    BASE_DIR=`pwd`
fi

echo "BASE_DIR: ${BASE_DIR}"
for SDK in "${SDKS[@]}"
do
    MODULE_DIR="${BASE_DIR}/Frameworks/${SDK}/CommonCrypto.framework"
    SDKPATH=`xcrun --sdk ${SDK} --show-sdk-path`
    rm -rf "${MODULE_DIR}"
    mkdir -p "${MODULE_DIR}"
    cat << EOF > ${MODULE_DIR}/module.map
module CommonCrypto [system] {
    header "${SDKPATH}/usr/include/CommonCrypto/CommonCrypto.h"
    header "${SDKPATH}/usr/include/CommonCrypto/CommonRandom.h"
    export *
}
EOF
    echo "Created CommonCrypto module map for ${SDK}."

    MODULE_DIR="${BASE_DIR}/Frameworks/${SDK}/ZLib.framework"
    SDKPATH=`xcrun --sdk ${SDK} --show-sdk-path`
    rm -rf "${MODULE_DIR}"
    mkdir -p "${MODULE_DIR}"
    cat << EOF > ${MODULE_DIR}/module.map
module ZLib [system] {
    header "${SDKPATH}/usr/include/zlib.h"
    link z
    export *
}
EOF
    echo "Created zlib module map for ${SDK}."
done

