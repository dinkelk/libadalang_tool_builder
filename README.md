# Libadalang Tool Builder

This little crate uses [Alire](https://alire.ada.dev/) to download the libadalang-tools source code, build, and install tools like `gnatpp` and `gnatmetric` to a desired location.

### How to build and install:

To build:

```
$ alr build --release
```

This can take a while. Install the binaries by running:

```
$ sh install.sh /path/to/destination/bin
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
