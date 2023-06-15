# Libadalang Tool Builder

A little crate that uses Alire to download the libadalang-tools source code and install the tools, ie. `gnatpp` and `gnatmetric` to a desired location. You can then remove this repository once the install is complete.

### How to build and install:

```
$ alr build --release
```

This can take a while. Install the binaries by running:

```
$ install.sh /path/to/destination/bin
```

### How this crate was first constructed:

```
$ alr init --bin libadalang_tool_builder 
$ cd libadalang_tool_builder
```

Then I added the following to the bottom of alire.toml.

```
[[depends-on]]
libadalang_tools = "23.0.0"
```
