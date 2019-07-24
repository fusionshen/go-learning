# go-learning



## Installing extra Go versions

It may be useful to have multiple Go versions installed on the same machine, for example, to ensure that a package's tests pass on multiple Go versions. Once you have one Go version installed, you can install another (such as 1.10.7) as follows:

```
$ go get golang.org/dl/go1.10.7
$ go1.10.7 download
```

The newly downloaded version can be used like `go`:

```
$ go1.10.7 version
go version go1.10.7 linux/amd64
```

All Go versions available via this method are listed on [the download page](https://godoc.org/golang.org/dl#pkg-subdirectories). You can find where each of these extra Go versions is installed by looking at its `GOROOT`; for example, `go1.10.7 env GOROOT`. To uninstall a downloaded version, just remove its `GOROOT` directory and the `goX.Y.Z` binary.

### Workspaces

A workspace is a directory hierarchy with two directories at its root:

- `src` contains Go source files, and
- `bin` contains executable commands.

The `go` tool builds and installs binaries to the `bin` directory.

The `src` subdirectory typically contains multiple version control repositories (such as for Git or Mercurial) that track the development of one or more source packages.

To give you an idea of how a workspace looks in practice, here's an example:

```
bin/
    hello                          # command executable
    outyet                         # command executable
src/
    github.com/golang/example/
        .git/                      # Git repository metadata
	hello/
	    hello.go               # command source
	outyet/
	    main.go                # command source
	    main_test.go           # test source
	stringutil/
	    reverse.go             # package source
	    reverse_test.go        # test source
    golang.org/x/image/
        .git/                      # Git repository metadata
	bmp/
	    reader.go              # package source
	    writer.go              # package source
    ... (many more repositories and packages omitted) ...
```

The tree above shows a workspace containing two repositories (`example` and `image`). The `example` repository contains two commands (`hello` and `outyet`) and one library (`stringutil`). The `image` repository contains the `bmp`package and [several others](https://godoc.org/golang.org/x/image).

A typical workspace contains many source repositories containing many packages and commands. Most Go programmers keep *all* their Go source code and dependencies in a single workspace.

Note that symbolic links should **not** be used to link files or directories into your workspace.

Commands and libraries are built from different kinds of source packages. We will discuss the distinction [later](https://golang.org/doc/code.html#PackageNames).

### The `GOPATH` environment variable

The `GOPATH` environment variable specifies the location of your workspace. It defaults to a directory named `go`inside your home directory, so `$HOME/go` on Unix, `$home/go` on Plan 9, and `%USERPROFILE%\go` (usually `C:\Users\YourName\go`) on Windows.

If you would like to work in a different location, you will need to [set `GOPATH`](https://golang.org/wiki/SettingGOPATH) to the path to that directory. (Another common setup is to set `GOPATH=$HOME`.) Note that `GOPATH` must **not** be the same path as your Go installation.

The command `go` `env` `GOPATH` prints the effective current `GOPATH`; it prints the default location if the environment variable is unset.

For convenience, add the workspace's `bin` subdirectory to your `PATH`:

```
$ export PATH=$PATH:$(go env GOPATH)/bin
```

The scripts in the rest of this document use `$GOPATH` instead of `$(go env GOPATH)` for brevity. To make the scripts run as written if you have not set GOPATH, you can substitute $HOME/go in those commands or else run:

```
$ export GOPATH=$(go env GOPATH)
```

To learn more about the `GOPATH` environment variable, see [`'go help gopath'`](https://golang.org/cmd/go/#hdr-GOPATH_environment_variable).

To use a custom workspace location, [set the `GOPATH` environment variable](https://golang.org/wiki/SettingGOPATH).

## Remote packages

An import path can describe how to obtain the package source code using a revision control system such as Git or Mercurial. The `go` tool uses this property to automatically fetch packages from remote repositories. For instance, the examples described in this document are also kept in a Git repository hosted at GitHub`github.com/golang/example`. If you include the repository URL in the package's import path, `go get` will fetch, build, and install it automatically:

```
$ go get github.com/golang/example/hello
$ $GOPATH/bin/hello
Hello, Go examples!
```

If the specified package is not present in a workspace, `go get` will place it inside the first workspace specified by `GOPATH`. (If the package does already exist, `go get` skips the remote fetch and behaves the same as `go install`.)

After issuing the above `go get` command, the workspace directory tree should now look like this:

```
bin/
    hello                           # command executable
src/
    github.com/golang/example/
	.git/                       # Git repository metadata
        hello/
            hello.go                # command source
        stringutil/
            reverse.go              # package source
            reverse_test.go         # test source
    github.com/user/
        hello/
            hello.go                # command source
        stringutil/
            reverse.go              # package source
            reverse_test.go         # test source
```

The `hello` command hosted at GitHub depends on the `stringutil` package within the same repository. The imports in `hello.go` file use the same import path convention, so the `go get` command is able to locate and install the dependent package, too.

```
import "github.com/golang/example/stringutil"
```

This convention is the easiest way to make your Go packages available for others to use. The [Go Wiki](https://golang.org/wiki/Projects) and [godoc.org](https://godoc.org/) provide lists of external Go projects.

For more information on using remote repositories with the `go` tool, see `go help importpath`.