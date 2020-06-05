//
// Copyright (c) 2020 Shamil
//
// Source: https://github.com/titools/titools
//
// Licensed under the MIT License.
//

import qbs
import "ti.js" as ti

Module {
    property string target

    property path compilerName
    property path assemblerName
    property path linkerName
    property path archiverName
    property path hexName // Hex Converter
    property path nmName // Name Utility
    property path stripName
    property path tconfName

    property pathList includePaths
    property pathList libraryPaths
    property pathList configPaths
    property pathList commandPaths
    property pathList sourcePaths

    property stringList staticLibraries

    property stringList defines

    property stringList compilerFlags
    property stringList linkerFlags

    property string compilerVersion
    property string biosVersion

    property string endianness: "little"
    PropertyOptions {
        name: "endianness"
        allowedValues: ["little", "big"]
        description: "Endianness."
    }

    property string outputFormat
    PropertyOptions {
        name: "outputFormat"
        allowedValues: ["elf", "coff"]
        description: "Output format."
    }

    property int optimizationLevel
    property int optimizeSize
    property int optimizeSpeed

    property int stackSize: 0x800
    property int heapSize: 0x800

    property string initialization: "rom"
    PropertyOptions {
        name: "initialization"
        allowedValues: ["rom", "ram"]
        description: "Initialization model."
    }

    property string mapFile

    // Advanced

    property path absName // Absolute Lister
    property path adviceName // Advice and Performance
    property path builderName // Library Builder
    property path consultantName // Consultant Generator
    property path demanglerName
    property path disassemblerName 
    property path embedName // Embed Utility
    property path libinfoName // Library Information Archiver
    property path mergeName // File Merge
    property path objectDisplayName // Object File Display
    property path prelinkName
    property path xrefName // XREF Utility

    property stringList misra

    Rule {
        id: archiver
        multiplex: true
        inputs: ["obj"]

        Artifact {
            filePath: product.destinationDirectory + "/" + product.targetName + ".lib"
            fileTags: ["staticlibrary"]
        }

        prepare: ti.prepareArchiver.apply(ti, arguments)
    }

    Rule {
        id: linker
        multiplex: true
        inputs: ["obj", "cmd"]
        inputsFromDependencies: ["library"]

        Artifact {
            filePath: product.destinationDirectory + "/" + product.targetName + ".out"
            fileTags: ["executable"]
        }

        prepare: ti.prepareLinker.apply(ti, arguments)
    }

    Rule {
        id: compiler
        inputs: ["asm", "c", "cpp"]
        auxiliaryInputs: ["hpp"]

        Artifact {
            fileTags: ["obj"]
            filePath: product.buildDirectory + "/" + input.completeBaseName + ".obj"
        }

        prepare: ti.prepareCompiler.apply(ti, arguments)
    }

    Rule {
        id: tconfCompiler
        inputs: ["tconf"]

        Artifact {
            fileTags: ["c"]
            filePath: product.buildDirectory + "/" + input.completeBaseName + "cfg_c.c"
        }

        Artifact {
            fileTags: ["hpp"]
            filePath: product.buildDirectory + "/" + input.completeBaseName + "cfg.h"
        }

        Artifact {
            fileTags: ["asm"]
            filePath: product.buildDirectory + "/" + input.completeBaseName + "cfg.s??"
        }

        Artifact {
            fileTags: ["cmd"]
            filePath: product.buildDirectory + "/" + input.completeBaseName + "cfg.cmd"
        }

        prepare: ti.prepareTconf.apply(ti, arguments)
    }

    // C sources
    FileTagger {
        patterns: ["*.c"]
        fileTags: ["c"]
    }

    // C++ sources
    FileTagger {
        patterns: ["*.C", "*.cpp", "*.cxx", "*.c++", "*.cc"]
        fileTags: ["cpp"]
    }

    // Headers
    FileTagger {
        patterns: ["*.h", "*.H", "*.hpp", "*.hxx", "*.h++"]
        fileTags: ["hpp"]
    }

    // Linker scripts
    FileTagger {
        patterns: ["*.cmd"]
        fileTags: ["cmd"]
    }

    // Assembler sources
    FileTagger {
        patterns: ["*.asm", "*.s??"]
        fileTags: ["asm"]
    }

    // BIOS configs
    FileTagger {
        patterns: "*.tcf"
        fileTags: ["tconf"]
    }
}
