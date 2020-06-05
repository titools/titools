//
// Copyright (c) 2020 Shamil
//
// Source: https://github.com/titools/titools
//
// Licensed under the MIT License.
//

import qbs

Product {
    property bool install: false
    property string installDir

    Depends { name: "cpp" }

    cpp.compilerFlags: {
        flags = [
            "--display_error_number",
            "--diag_warning=225",
        ];
        if (qbs.architecture == "c2000")
            flags.push("-ml", "-mt");
        return flags;
    }

    cpp.linkerFlags: ["--reread_libs", "--display_error_number"]

    property stringList defines: {
        var defines = [
            "c" + cpp.target,
            "CHIP_" + cpp.target,
        ];
        if (cpp.target) {
            if (cpp.target.startsWith("6"))
                defines.push("_TMS320C6X", "__TMS320C6X__");
            if (cpp.target.startsWith("64"))
                defines.push("_TMS320C6400");
            else if (cpp.target.startsWith("66"))
                defines.push("_TMS320C6600");
            else if (cpp.target.startsWith("674"))
                defines.push("_TMS320C6740");
            else if (cpp.target.startsWith("67"))
                defines.push("_TMS320C6700");
        }
        if (qbs.buildVariant == "debug")
            defines.push("_DEBUG");
        return defines;
    }

    property pathList includePaths: [
        buildDirectory,
    ]

    property stringList staticLibraries: [
        "libc.a",
    ]
}
