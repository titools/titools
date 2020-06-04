import qbs

TiApplication {
    name: "c6415-app"
    install: true

    cpp.target: "6415"
    cpp.outputFormat: "coff"
    cpp.endianness: "little"
    cpp.optimizationLevel: 3

    files: [
        "*.asm",
        "*.cmd",
        "*.cpp",
        "*.h",
    ]
}

