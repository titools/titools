//
// Copyright (c) 2020 Shamil
//
// Source: https://github.com/titools/titools
//
// Licensed under the MIT License.
//

import qbs

TiProduct {
    type: ["executable"]

    installDir: ""

    Group {
        condition: install
        fileTagsFilter: "executable";
        qbs.install: true
        qbs.installPrefix: ""
        qbs.installDir: installDir
        qbs.installSourceBase: outer
    }
}
