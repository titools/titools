#!/bin/bash
#
# Copyright (c) 2020 Shamil
#
# Source: https://github.com/titools/titools
#
# Licensed under the MIT License.
#

sudo rm -fv /usr/bin/titools

sudo rm -fv /usr/share/qbs/imports/qbs/base/TiApplication.qbs
sudo rm -fv /usr/share/qbs/imports/qbs/base/TiLibrary.qbs
sudo rm -fv /usr/share/qbs/imports/qbs/base/TiProduct.qbs
sudo rm -fv /usr/share/qbs/modules/cpp/ti.qbs
sudo rm -fv /usr/share/qbs/modules/cpp/ti.js

