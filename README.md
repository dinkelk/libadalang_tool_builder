# Libadalang Tool Builder

This little repository uses [Alire](https://alire.ada.dev/) to download the libadalang-tools source code, build, and install tools like `gnatpp` and `gnatmetric` to a desired location.

### How to build and install:

Make sure you have [Alire](https://alire.ada.dev/) installed. Then clone this repository:

```
$ git clone https://github.com/dinkelk/libadalang_tool_builder.git
```

To build:

```
$ cd libadalang_tool_builder
$ alr build --release
```

This can take a while. Install the binaries by running:

```
$ sh install.sh /path/to/destination/bin
```

Alternatively, there is a [Dockerfile](docker/) available with the libadalang tools precompiled and preinstalled.

### How this repository was first constructed:

```
$ alr init --bin libadalang_tool_builder 
$ cd libadalang_tool_builder
```

Then I added the following to the bottom of alire.toml.

```
[[depends-on]]
libadalang_tools = "23.0.0"
```
