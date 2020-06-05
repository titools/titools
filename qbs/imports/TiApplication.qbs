//
// Copyright (c) 2020 Shamil
//
// Source: https://github.com/titools/titools
//
// Licensed under the MIT License.
//

import qbs

TiProduct {
    type: {
        var types = ["executable"];
        if (cpp.hexFile !== undefined)
            types.push("hex");
        return types;
    }

    installDir: ""

    Group {
        condition: install
        fileTagsFilter: ["executable", "hex"]
        qbs.install: true
        qbs.installPrefix: ""
        qbs.installDir: installDir
        qbs.installSourceBase: outer
    }
}
