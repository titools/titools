//
// Copyright (c) 2020 Shamil
//
// Source: https://github.com/titools/titools
//
// Licensed under the MIT License.
//

var File = require("qbs.File");

function commonArgs(input) {
    var args = [];

    var target = input.cpp.target;
    if (target.startsWith("28"))
        args.push("-v28");
    else if (target.startsWith("62"))
        args.push("-mv6200");
    else if (target.startsWith("64"))
        args.push("-mv6400");
    else if (target.startsWith("66"))
        args.push("-mv6600");

    if (input.cpp.endianness && input.cpp.endianness.toLowerCase() == "big")
        args.push("--big_endian");

    var abi = (input.cpp.outputFormat && input.cpp.outputFormat.toLowerCase()) == "coff" ? "coffabi" : "eabi";
    args.push("--abi=" + abi);

    if (input.qbs.buildVariant == "debug") {
        args.push("-g");
    } else if (input.qbs.buildVariant == "release") {
        if (input.cpp.optimizationLevel)
            args.push("-O" + input.cpp.optimizationLevel);
        if (input.cpp.optimizationSize)
            args.push("-ms" + input.cpp.optimizationSize);
    }

    return args;
}

function prepareArchiver(project, product, inputs, outputs, input, output, explicitlyDependsOn) {
    var args = [];

    args.push("r", output.filePath); // Output file

    for (var i in inputs.obj)
        args.push(inputs.obj[i].filePath);

    var cmd = new Command(input.cpp.archiverName, args);
    cmd.description = "linking " + output.fileName;
    cmd.highlight = "linker";
    cmd.jobPool = "linker";
    cmd.workingDirectory = product.destinationDirectory;

    return cmd;
}

function prepareCompiler(project, product, inputs, outputs, input, output, explicitlyDependsOn) {
    var filePath = input.filePath;
    var fileName = input.fileName;
    if (input.filePath.endsWith("??")) {
        var exts = ["28", "62", "64", "66"];
        for (var i in exts) {
            filePath = input.filePath.replace(/\?\?$/, exts[i]);
            fileName = input.fileName.replace(/\?\?$/, exts[i]);
            if (File.exists(filePath))
                break;
        }
    }
    if (!File.exists(filePath))
        throw new Error("File doesn't exist: " + filePath);

    var args = commonArgs(input);

    args = args.concat(unitedArgs("--define=", product.defines, input.cpp.defines));
    args = args.concat(unitedArgs("-i", product.includePaths, input.cpp.includePaths));
    args.push(filePath); // Source file

    var compilerFlags = input.cpp.compilerFlags;
    for (var i in compilerFlags)
        args.push(compilerFlags[i]);

    var cmd = new Command(input.cpp.compilerName, args);
    cmd.description = "compiling " + fileName;
    cmd.highlight = "compiler";
    cmd.jobPool = "compiler";
    cmd.workingDirectory = product.destinationDirectory;

    return cmd;
}

function prepareLinker(project, product, inputs, outputs, input, output, explicitlyDependsOn) {
    var args = commonArgs(product);

    args.push("-z"); // Invoke linker

    args.push("--stack_size=" + product.cpp.stackSize);
    args.push("--heap_size=" + product.cpp.heapSize);

    var init = product.cpp.initialization;
    if (init) {
        if (init.toLowerCase() == "rom")
            args.push("--rom_model");
        else if (init.toLowerCase() == "ram")
            args.push("--ram_model");
    }

    args = args.concat(unitedArgs("-i", product.libraryPaths, product.cpp.libraryPaths));
    args.push("-o", output.filePath); // Output file

    for (var i in inputs.obj)
        args.push(inputs.obj[i].filePath);

    for (var i in inputs.cmd)
        args.push(inputs.cmd[i].filePath);

    args = args.concat(unitedArgs("-l", product.staticLibraries, product.cpp.staticLibraries));

    var linkerFlags = product.cpp.linkerFlags;
    for (var i in linkerFlags)
        args.push(linkerFlags[i]);

    var cmd = new Command(product.cpp.linkerName, args);
    cmd.description = "linking " + output.fileName;
    cmd.highlight = "linker";
    cmd.jobPool = "linker";
    cmd.workingDirectory = product.destinationDirectory;

    return cmd;
}

function prepareTconf(project, product, inputs, outputs, input, output, explicitlyDependsOn) {
    var args = [];

    args.push("-b");

    var configPaths = unitedParams(product.configPaths, input.cpp.configPaths);
    var fullPath = configPaths.join("\;");
    if (fullPath.length > 0)
        args.push("-Dconfig.importPath=" + fullPath + "\;");

    args.push(input.filePath); // Source file

    var cmd = new Command(input.cpp.tconfName, args);
    cmd.description = "configuring " + input.fileName;
    cmd.highlight = "compiler";
    cmd.jobPool = "compiler";
    cmd.workingDirectory = product.destinationDirectory;

    return cmd;
}

function unitedArgs(arg, defaultParams, params) {
    args = []
    var allParams = unitedParams(defaultParams, params);
    for (i in allParams)
        args.push(arg + allParams[i]);
    return args;
}

function unitedParams(defaultParams, params) {
    var allParams = [];
    if (defaultParams)
        allParams = allParams.uniqueConcat(defaultParams);
    if (params)
        allParams = allParams.uniqueConcat(params);
    return allParams;
}
