import qbs

TiLibrary {
    name: "c6415-lib"
    install: true

    cpp.target: "6415"
    cpp.outputFormat: "coff"
    cpp.endianness: "little"
    cpp.optimizationSize: 3

    files: [
        "*.cpp",
        "*.h",
    ]
}

