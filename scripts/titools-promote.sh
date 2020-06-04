#!/bin/bash
#
# Copyright (c) 2020 Shamil
#
# Source: https://github.com/titools/titools
#
# Licensed under the MIT License.
#

cd "$(dirname $0)/.."

if [[ ! -d "/usr/share/qbs" ]]; then
    echo -e "Error: Install QBS first\n\nsudo apt install qbs"
    exit 1
fi

sudo cp -frv ./qbs/imports/* /usr/share/qbs/imports/qbs/base/
sudo cp -frv ./qbs/modules/* /usr/share/qbs/modules/
sudo cp -fv ./titools /usr/bin/

