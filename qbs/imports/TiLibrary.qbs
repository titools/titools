//
// Copyright (c) 2020 Shamil
//
// Source: https://github.com/titools/titools
//
// Licensed under the MIT License.
//

import qbs

TiProduct {
    type: ["staticlibrary"]

    installDir: ""

    Group {
        condition: install
        fileTagsFilter: "staticlibrary";
        qbs.install: true
        qbs.installPrefix: ""
        qbs.installDir: installDir
        qbs.installSourceBase: outer
    }
}
