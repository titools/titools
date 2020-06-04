TI Tools
========

Tools that make it easy to build embedded applications.

Setup Tools
-----------

The following script configures TI tools to be used together with Qt Build System (QBS). The host OS is expected to be Ubuntu.

Step 1. Install `qbs` and `wget`:

    sudo apt install qbs wget

Step 2. Install and configure desired versions of Code Generation Tools, DSP/BIOS, CSL to the current directory:

    ./titools cgt-c6000 7.4.20
    ./titools csl-c6000 2.31.00
    ./titools bios 5.42.02

Step 3. Build examples:

    qbs config:release

Step 4. Find output files in `./release/install-root` directory.

Installing Tools to a Dedicated Directory
-----------------------------------------

Add third `<dest-dir>` argument:

    ./titools cgt-c6000 7.4.20 ~/titools
    ./titools csl-c6000 2.31.00 ~/titools
    ./titools bios 5.42.02 ~/titools

Tools will be installed to `$HOME/titools` directory.

License
=======

Source code is licensed under [MIT License](LICENSE).
