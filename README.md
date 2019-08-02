# golang说明
1. 环境配置
2. 包管理工具
3. 总结

## 环境配置

### Win10

#### 开发包安装
- go老版本请先卸载。
- Windows 下可以使用 .msi安装包来安装[安装包地址](https://golang.org/dl/)，当前版本go1.12.7.windows-amd64.msi，选择默认, 文件会安装在 c:\Go 目录下。
  
#### 环境变量
安装后会自动配置相关环境变量，win10中搜索框输入***env***可快速呼出环境变量，系统变量Path会自动添加%GOROOT%\bin和C:\Go\bin。其中GOROOT就是指向c:\\Go, 可在git-bash中输入go env GOROOT查看。

#### 工作目录
我的理解：工作目录就是在本机保证整个go代码生态的文件夹，不是项目级别，而是整个语言级别的包管理模式。
      
- 新建工作目录文件夹，本人为D:\go-work。
- 环境变量中的用户变量和系统变量添加GOPATH: D:\go-work,可在git-bash中输入go env GOPATH查看。
- 我还在用户变量Path中添加了%GOPATH%\bin，这个可以确保全局执行install后的exe。
- 记住要重启机器！
- 还需要在工作目录中手建src文件夹，这里会存放所有代码，bin和pkg在某些操作后会自动生成。
```bash
$ tree -a -L 4
.
|-- .vscode
|   |-- launch.json
|   `-- settings.json
|-- bin
|   |-- deadcode.exe
|   |-- dlv.exe
|   |-- dupl.exe
|   |-- errcheck.exe
|   |-- fillstruct.exe
|   |-- go-outline.exe
|   |-- go-symbols.exe
|   |-- gochecknoglobals.exe
|   |-- gochecknoinits.exe
|   |-- gocode-gomod.exe
|   |-- gocode.exe
|   |-- goconst.exe
|   |-- gocyclo.exe
|   |-- godef.exe
|   |-- godoc.exe
|   |-- gogetdoc.exe
|   |-- goimports.exe
|   |-- golint.exe
|   |-- gometalinter.exe
|   |-- gomodifytags.exe
|   |-- gopkgs.exe
|   |-- goplay.exe
|   |-- gorename.exe
|   |-- goreturns.exe
|   |-- gosec.exe
|   |-- gotests.exe
|   |-- gotype.exe
|   |-- guru.exe
|   |-- hello.exe
|   |-- impl.exe
|   |-- ineffassign.exe
|   |-- interfacer.exe
|   |-- lll.exe
|   |-- maligned.exe
|   |-- misspell.exe
|   |-- nakedret.exe
|   |-- safesql.exe
|   |-- staticcheck.exe
|   |-- structcheck.exe
|   |-- unconvert.exe
|   |-- unparam.exe
|   `-- varcheck.exe
|-- pkg
|   `-- windows_amd64
|       `-- github.com
|           |-- cweill
|           `-- fusionshen
`-- src
    |-- github.com
    |   |-- acroca
    |   |   `-- go-symbols
    |   |-- alecthomas
    |   |   `-- gometalinter
    |   |-- cweill
    |   |   `-- gotests
    |   |-- davidrjenni
    |   |   `-- reftools
    |   |-- fatih
    |   |   `-- gomodifytags
    |   |-- fusionshen
    |   |   `-- go-learning
    |   |-- go-delve
    |   |   `-- delve
    |   |-- golang
    |   |   `-- example
    |   |-- haya14busa
    |   |   `-- goplay
    |   |-- josharian
    |   |   `-- impl
    |   |-- karrick
    |   |   `-- godirwalk
    |   |-- mattn
    |   |   `-- go-runewidth
    |   |-- mdempsky
    |   |   `-- gocode
    |   |-- peterh
    |   |   `-- liner
    |   |-- pkg
    |   |   `-- errors
    |   |-- ramya-rao-a
    |   |   `-- go-outline
    |   |-- rogpeppe
    |   |   `-- godef
    |   |-- skratchdot
    |   |   `-- open-golang
    |   |-- sqs
    |   |   `-- goreturns
    |   |-- stamblerre
    |   |   `-- gocode
    |   |-- uudashr
    |   |   `-- gopkgs
    |   `-- zmb3
    |       `-- gogetdoc
    |-- golang.org
    |   `-- x
    |       |-- lint
    |       |-- net
    |       `-- tools
    `-- sourcegraph.com
        `-- sqs
        `-- goreturns
    
62 directories, 44 files
```
**go-learning**在src/github.com/fusionshen/go-learning文件夹中，其余项目都是本地vsc开发环境必须的，后面会详细描述。

由上可以推断，项目中使用的第三方库也是这种模式存在于整个工作目录中，避免重复造轮子。

>关于tree命令的添加可以查看[git-bash tree](https://blog.csdn.net/t3369/article/details/80517097)。

#### 初次写helloworld会提示安装gocode插件安装，点击安装会一直报错，解决方案如下：
```bash
gocode:
Error: Command failed: /c/go/bin/go get -u -v github.com/mdempsky/gocode
github.com/mdempsky/gocode (download)
Fetching https://golang.org/x/tools/go/gcexportdata?go-get=1
https fetch failed: Get https://golang.org/x/tools/go/gcexportdata?go-get=1: dial tcp 216.239.37.1:443: i/o timeout
package golang.org/x/tools/go/gcexportdata: unrecognized import path "golang.org/x/tools/go/gcexportdata" (https fetch: Get https://golang.org/x/tools/go/gcexportdata?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
```
- 请确保自己正在科学上网。
- 即使是科学上网也会提示上述错误，总结说来是因为本机没有golang.org工具源码。
1. git-bash创建目录$GOPATH/src/golang.org/x，并切换到该目录
```bash
export GOPATH=$(go env GOPATH)
mkdir -p $GOPATH/src/golang.org/x/
cd $GOPATH/src/golang.org/x/
```
2. 克隆golang.org工具源码
如果不克隆的话，go get -u -v golang.org/xxx肯定是timeout的，所以只能先把它们下载到本地src/golang.org/x/tools。         
```bash
git clone https://github.com/golang/tools.git
git clone https://github.com/golang/net.git
git clone https://github.com/golang/lint.git
git clone https://github.com/golang/crypto
git clone https://github.com/golang/text
```
3. 通过tree值可查看到golang.org中的五个工具包

#### 开始安装VSCode依赖的几款工具，包括上面提到的gocode，如果失败多试几次，成功后src下的目录结构就如同tree相似
```bash
go get -v github.com/ramya-rao-a/go-outline
go get -v github.com/acroca/go-symbols
go get -v github.com/mdempsky/gocode
go get -v github.com/rogpeppe/godef
go get -v github.com/zmb3/gogetdoc
go get -v github.com/fatih/gomodifytags
go get -v sourcegraph.com/sqs/goreturns
go get -v github.com/cweill/gotests/...
go get -v github.com/josharian/impl
go get -v github.com/haya14busa/goplay/cmd/goplay
go get -v github.com/uudashr/gopkgs/cmd/gopkgs
go get -v github.com/davidrjenni/reftools/cmd/fillstruct
go get -v github.com/alecthomas/gometalinter
```

####  安装工具，执行成功后就是tree中的bin目录结构了
```bash
go install github.com/ramya-rao-a/go-outline
go install github.com/acroca/go-symbols
go install github.com/mdempsky/gocode
go install github.com/rogpeppe/godef
go install github.com/zmb3/gogetdoc
go install github.com/fatih/gomodifytags
go install sourcegraph.com/sqs/goreturns
go install github.com/cweill/gotests/...
go install github.com/josharian/impl
go install github.com/haya14busa/goplay/cmd/goplay
go install github.com/uudashr/gopkgs/cmd/gopkgs
go install github.com/davidrjenni/reftools/cmd/fillstruct
go install github.com/alecthomas/gometalinter
$GOPATH/bin/gometalinter --install
go install golang.org/x/tools/cmd/godoc
go install golang.org/x/lint/golint
go install golang.org/x/tools/cmd/gorename
go install golang.org/x/tools/cmd/goimports
go install golang.org/x/tools/cmd/guru
```

各种工具具体作用如下表，没有经历过开发验证，也许有更好的第三方工具可以替代。

| **名称**      | **描述**           | **链接**                                                     |
| ------------- | ------------------ | ------------------------------------------------------------ |
| gocode        | 代码自动补全       | https://github.com/mdempsky/gocode                           |
| go-outline    | 在当前文件中查找   | https://github.com/ramya-rao-a/go-outline                    |
| go-symbols    | 在项目路径下查找   | https://github.com/acroca/go-symbols                         |
| gopkgs        | 自动补全未导入包   | https://github.com/uudashr/gopkgs                            |
| guru          | 查询所有引用       | https://golang.org/x/tools/cmd/guru                          |
| gorename      | 重命名符号         | https://golang.org/x/tools/cmd/gorename                      |
| goreturns     | 格式化代码         | https://github.com/sqs/goreturns                             |
| godef         | 跳转到声明         | https://github.com/rogpeppe/godef                            |
| godoc         | 鼠标悬浮时文档提示 | https://golang.org/x/tools/cmd/godoc                         |
| golint        | 就是lint           | https://golang.org/x/lint/golint                             |
| dlv           | 调试功能           | https://github.com/derekparker/delve/tree/master/cmd/dlv     |
| gomodifytags  | 修改结构体标签     | https://github.com/fatih/gomodifytags                        |
| goplay        | 运行当前go文件     | https://github.com/haya14busa/goplay/                        |
| impl          | 新建接口           | https://github.com/josharian/impl                            |
| gotype-live   | 类型诊断           | https://github.com/tylerb/gotype-live                        |
| gotests       | 单元测试           | https://github.com/cweill/gotests/                           |
| go-langserver | 语言服务           | https://github.com/sourcegraph/go-langserver                 |
| filstruct     | 结构体成员默认值   | https://github.com/davidrjenni/reftools/tree/master/cmd/fillstruct |

####  调试
如上图工具介绍可知，dlv是调试的工具，支持单步调试的功能，经本机测试确实能够实现，由此可知，vsc就是利用第三方工具手动组装成IDE。
`go get -v -u github.com/peterh/liner github.com/derekparker/delve/cmd/dlv`

####  工作区设置
- .vscode/settings.json
```json
{

    "files.autoSave": "onFocusChange",

    "go.buildOnSave": "package",

    "go.lintOnSave": "package",

    "go.vetOnSave": "package",

    "go.buildFlags": [],

    "go.lintFlags": [],

    "go.vetFlags": [],

    "go.useCodeSnippetsOnFunctionSuggest": false,

    "go.formatTool": "goreturns",

    "go.goroot": "C:\\Go",

    "go.gopath": "D:\\go-work"

}
```
- .vscode/launch.json
```json
{
    // Use IntelliSense to learn about possible attributes.
    // Hover to view descriptions of existing attributes.
    // For more information, visit: https://go.microsoft.com/fwlink/?linkid=830387
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Launch",
            "type": "go",
            "request": "launch",
            "mode": "debug",
            "program": "${workspaceRoot}/src/github.com/fusionshen/go-learning/hello/hello.go",
            "env": {},
            "args": []
        }
    ]
}
```
### Mac
[VSC环境](https://www.jianshu.com/p/f952042af8ff)



## 包管理工具
### 发展历史  [参考1](https://studygolang.com/articles/18670)，[参考2](https://studygolang.com/articles/10312)，[参考3](https://segmentfault.com/a/1190000018536993)

#### golang1.5以前
golang的包管理一直让人诟病，1.5以前，它一直使用`GOPATH`来进行依赖库管理，简单粗暴。

但是不同依赖包是有版本的，版本变了怎么办？这就需要人工管理了。

开发者自己管理库版本，想想都不太可能，毕竟Java有maven，Python有pip，PHP有compose，NodeJs有npm，C#有NuGet。

在Go 1.6之前，你需要手动的设置环境变量`GO15VENDOREXPERIMENT=1`才可以使Go找到vendor目录，然而在Go 1.6之后，这个功能已经不需要配置环境变量就可以实现了。

>即使使用**vendor**，也必须在**GOPATH**中，在go的工具链中，你逃不掉**GOPATH**的

#### golang1.6以后
从golang1.5开始推出vendor(供应商/小贩)文件夹机制。从golang1.6正式开启这个功能，查找vendor是往上冒泡的，一个包引用另一个包，先看看同目录vendor下有没有这个包， 没有的话一直追溯到上一层vendor看有没有，没有的话再上一层vendor，直到 GOPATH src/vendor。

所以现在的加载流程是：
```
包同目录下的vendor
包目录向上的最近的一个vendor
...
GOPATH src 下的vendor
GOROOT src
GOPATH src
```
这样的话， 我们可以把包的依赖都放在 vendor 下，然后提交到仓库，这样可以省却拉取包的时间，并且相对自由，你想怎么改都可以，你可以放一个已经被人删掉的 github 包在 vendor 下。

这样，依然手动，没法管理依赖版本。

所以很多第三方，比如 glide , godep, govendor 工具出现了， 使用这些工具， 依赖包必须有完整的 git 版本， 然后会将所有依赖的版本写在一个配置文件中。

比如 godep ：`go get -v github.com/tools/godep`,在包下执行`godep save`会生成 Godeps/Godep.json记录依赖版本，并且将包收集于当前vendor下。

>使用vendor的几点建议

1. 一个库工程（不包含main的package）不应该在自己的版本控制中存储外部的包在`vendor`目录中，除非他们有特殊原因并且知道为什么要这么做。
2. 在一个应用中，（包含main的package），建议只有一个vendor目录在代码库一级目录。

>原因如下：

* 在目录结构中的每个包的实例，即使是同一个包的同一个版本，都会打到最终的二进制文件中，如果每个人都单独的存储自己的依赖包，会迅速导致生成文件的二进制爆发（binary bloat)
* 在一个目录的某个package类型，并不兼容在同一个package但是在不同目录的类型，即便是同一个版本的package，那意味着loggers，数据库连接，和其他共享的实例都没法工作。

>为什么用vendor目录

如果我们已经使用GOPATH去存储packages了，问什么还需要使用vendor目录呢？这是一个很实战的问题。假如多个应用使用一个依赖包的不同版本？这个问题不只是Go应用，其他语言也会有这个问题。

vendor目录允许不同的代码库拥有它自己的依赖包，并且不同于其他代码库的版本，这就很好的做到了工程的隔离。

#### golang1.11之后
go modules 是 golang 1.11 新加的特性。现在1.12 已经发布了，是时候用起来了。

Modules官方定义为：
```
模块是相关Go包的集合。modules是源代码交换和版本控制的单元。 go命令直接支持使用modules，包括记录和解析对其他模块的依赖性。modules替换旧的基于GOPATH的方法来指定在给定构建中使用哪些源文件。
```
##### 如何使用Modules

1.把golang 升级到 1.11（现在1.12 已经发布了，建议使用1.12）
2.设置GO111MODULE，其实就是把项目移出**GOPATH**,并使用`go mod init`初始化go.mod文件, 移入**GOPATH**，就自动禁用了mod功能，还会检验你的import写法

```bash
go get: warning: modules disabled by GO111MODULE=auto in GOPATH/src;
ignoring go.mod;
see 'go help modules'
package de-api/routers: unrecognized import path "de-api/routers" (import path does not begin with hostname)
```
>这样其实是不方便的，在不在**GOPATH**运行，还得把`import "de-api/routers"`改来改去`import "github.com/fusionshen/de-api/routers"`,不知道官方什么时候出解决方案。

##### GO111MODULE

`GO111MODULE` 有三个值：`off`, `on`和`auto（默认值）`。

- `GO111MODULE=off`，go命令行将不会支持module功能，寻找依赖包的方式将会沿用旧版本那种通过vendor目录或者GOPATH模式来查找。
- `GO111MODULE=on`，go命令行会使用modules，而一点也不会去GOPATH目录下查找。
- `GO111MODULE=auto`，默认值，go命令行将会根据当前目录来决定是否启用module功能。这种情况下可以分为两种情形：
  - 当前目录在GOPATH/src之外且该目录包含go.mod文件
  - 当前文件在包含go.mod文件的目录下面。

> 当modules 功能启用时，依赖包的存放位置变更为`$GOPATH/pkg`，允许同一个package多个版本并存，且多个项目可以共享缓存的 module。

##### go mod

golang 提供了 `go mod`命令来管理包。

go mod 有以下命令：

| 命令     | 说明                                                         |
| :------- | :----------------------------------------------------------- |
| download | download modules to local cache(下载依赖包)                  |
| edit     | edit go.mod from tools or scripts（编辑go.mod                |
| graph    | print module requirement graph (打印模块依赖图)              |
| init     | initialize new module in current directory（在当前目录初始化mod） |
| tidy     | add missing and remove unused modules(拉取缺少的模块，移除不用的模块) |
| vendor   | make vendored copy of dependencies(将依赖复制到vendor下)     |
| verify   | verify dependencies have expected content (验证依赖是否正确） |
| why      | explain why packages or modules are needed(解释为什么需要依赖) |

### 如何在项目中使用
- 没有使用godep，govendor，dep，glide等包管理工具的项目
- 已使用其它包管理工具的项目迁移工作

>不管是上述哪种项目，需要将项目移出**GOPATH**，不然会让go mod自动关闭

#### 无包管理工具项目使用`go mode`

- 在`GOPATH 目录之外`新建项目或者将已有项目移出去，并使用`go mod init` 初始化生成`go.mod` 文件

```
Fusionshen@Fusionshen MINGW64 /d/fusionshen/de-api (master)
$ go mod init
go: cannot determine module path for source directory D:\fusionshen\de-api (outside GOPATH, no import comments)

Fusionshen@Fusionshen MINGW64 /d/fusionshen/de-api (master)
$ go mod init de-api
go: creating new go.mod: module de-api
```
>有趣的是go mod init方法还需要制定一个de-api的名字

> go.mod文件一旦创建后，它的内容将会被go toolchain全面掌控。go toolchain会在各类命令执行时，比如go get、go build、go mod等修改和维护go.mod文件。

>go.mod文件是这样的
```bash
module de-api

go 1.12
```

- 然后我们尝试运行这个项目`go run main.go`，然后会出现
```bash
Fusionshen@Fusionshen MINGW64 /d/fusionshen?/de-api (master)
$ go run main.go
go: golang.org/x/crypto@v0.0.0-20181127143415-eb0de9b17e85: unrecognized import path "golang.org/x/crypto" (https fetch: Get https://golang.org/x/crypto?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: golang.org/x/net@v0.0.0-20181114220301-adae6a3d119a: unrecognized import path "golang.org/x/net" (https fetch: Get https://golang.org/x/net?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: error loading module requirements
```

> 又是我们熟悉的容易出问题的工具库，让上一节环境设置时候我们已经遭遇过，不过那时我们在**GOPATH**下，但是可以理解我们使用的beego是个第三方框架，它会大量使用官方库和其它第三方库，肯定需要引入第三方依赖的，但是golang.org/x/crypto@v0.0.0-20181127143415-eb0de9b17e85这一串又是几个意思？

其实就是对应的是这个库提交时间和提交码，这些在github上能够找到。

> go mod自动计算的这些依赖，如果在$GOPATH/pkg/mod中存在就跳过去，不存在就去下载并安装，而且你会发现同一个包会下载多次，就像下面

```bash
Fusionshen@Fusionshen MINGW64 /d/fusionshen/de-api (master)
$ go run main.go
go: finding github.com/golang/crypto latest
go: finding github.com/golang/net latest
go: golang.org/x/sys@v0.0.0-20190412213103-97732733099d: unrecognized import path "golang.org/x/sys" (https fetch: Get https://golang.org/x/sys?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: golang.org/x/sys@v0.0.0-20190215142949-d0b11bdaac8a: unrecognized import path "golang.org/x/sys" (https fetch: Get https://golang.org/x/sys?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: golang.org/x/net@v0.0.0-20190404232315-eb5bcb51f2a3: unrecognized import path "golang.org/x/net" (https fetch: Get https://golang.org/x/net?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: golang.org/x/crypto@v0.0.0-20190308221718-c2843e01d9a2: unrecognized import path "golang.org/x/crypto" (https fetch: Get https://golang.org/x/crypto?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: golang.org/x/text@v0.3.0: unrecognized import path "golang.org/x/text" (https fetch: Get https://golang.org/x/text?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
go: error loading module requirements

```

> golang.org/x/sys就存在两个不同的版本，而且net和crypto也都又请求了一次，为什么会这样？因为beego本身或者引用的其它的第三方库就使用了相同库的版本。这就是`go mod`存在的价值，能够解决不同版本的依赖。

>我们知道golang.org/x/被墙，就算科学上网也解决不了，第一节里面我们是自己手动下载git代码库，有一个移花接木的技巧，这里也一样。我们先看一看go.mod文件里面的命令。


go.mod 提供了`module`, `require`、`replace`和`exclude` 四个命令

- `module` 语句指定包的名字（路径）
- `require` 语句指定的依赖项模块
- `replace` 语句可以替换依赖项模块
- `exclude` 语句可以忽略依赖项模块

[我从这篇日志找到了灵感](https://yq.aliyun.com/articles/663151)

然后我根据报错信息尝试将go.mod文件手动改成这样

```bash
module de-api

go 1.12

replace (
	golang.org/x/crypto v0.0.0-20181127143415-eb0de9b17e85 => github.com/golang/crypto latest
	golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2 => github.com/golang/crypto latest
	golang.org/x/net v0.0.0-20181114220301-adae6a3d119a => github.com/golang/net latest
	golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3 => github.com/golang/net latest
	golang.org/x/net v0.0.0-20190620200207-3b0461eec859 => github.com/golang/net latest
	golang.org/x/sync v0.0.0-20190423024810-112230192c58 => github.com/golang/sync latest
	golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a => github.com/golang/sys latest
	golang.org/x/sys v0.0.0-20190412213103-97732733099d => github.com/golang/sys latest
	golang.org/x/text v0.3.0 => github.com/golang/text latest
	golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e => github.com/golang/tools latest
	golang.org/x/tools v0.0.0-20190328211700-ab21143f2384 => github.com/golang/tools latest
)
```

运行成功之后发现go.mod变成这样

```
module de-api

go 1.12

replace (
	golang.org/x/crypto v0.0.0-20181127143415-eb0de9b17e85 => github.com/golang/crypto v0.0.0-20190701094942-4def268fd1a4
	golang.org/x/crypto v0.0.0-20190308221718-c2843e01d9a2 => github.com/golang/crypto v0.0.0-20190701094942-4def268fd1a4
	golang.org/x/net v0.0.0-20181114220301-adae6a3d119a => github.com/golang/net v0.0.0-20190724013045-ca1201d0de80
	golang.org/x/net v0.0.0-20190404232315-eb5bcb51f2a3 => github.com/golang/net v0.0.0-20190724013045-ca1201d0de80
	golang.org/x/net v0.0.0-20190620200207-3b0461eec859 => github.com/golang/net v0.0.0-20190724013045-ca1201d0de80
	golang.org/x/sync v0.0.0-20190423024810-112230192c58 => github.com/golang/sync v0.0.0-20190423024810-112230192c58
	golang.org/x/sys v0.0.0-20190215142949-d0b11bdaac8a => github.com/golang/sys v0.0.0-20190801041406-cbf593c0f2f3
	golang.org/x/sys v0.0.0-20190412213103-97732733099d => github.com/golang/sys v0.0.0-20190801041406-cbf593c0f2f3
	golang.org/x/text v0.3.0 => github.com/golang/text v0.3.2
	golang.org/x/tools v0.0.0-20180917221912-90fa682c2a6e => github.com/golang/tools v0.0.0-20190731214159-1e85ed8060aa
	golang.org/x/tools v0.0.0-20190328211700-ab21143f2384 => github.com/golang/tools v0.0.0-20190731214159-1e85ed8060aa
)

require (
	github.com/astaxie/beego v1.12.0
	github.com/shiena/ansicolor v0.0.0-20151119151921-a422bbe96644 // indirect
	github.com/smartystreets/goconvey v0.0.0-20190731233626-505e41936337
	gopkg.in/yaml.v2 v2.2.2 // indirect
)

```

> 说明go mod会自动去查找并替换latest为最新的一次提交，而且会自动生成require信息，//indirect表示不直接引用？最重要的是终于摆脱了**GOPATH**，我们的beego api项目成功运行了。
>
> 还需要注意`bee api de-api `是将项目生成在`$GOPATH/src`下，应该手动将它移到工作空间，如果要使用swagger功能还需要运行一次 `bee run -gendoc=true -downdoc=true`再移出来。不知道这是不是beego的一个bug。

go module 安装 package 的原则是先拉最新的 release tag，若无tag则拉最新的commit，详见 [Modules官方介绍](https://github.com/golang/go/wiki/Modules)。 go 会自动生成一个 go.sum 文件来记录 dependency tree：

>go.sum看起来都是例举的包的信息，现在还不知道具体是什么意思。go.sum不要手动修改，k8s的go.mod也是用脚本修改的，也建议不要手动修改，可是脚本我不会啊。

1. 再次执行脚本 `go run main.go` 发现跳过了检查并安装依赖的步骤。(因为已经全部安装好了，依赖就在`$GOPATH/pkg/mod`中)
2. 可以使用命令 `go list -m -u all` 来检查可以升级的package，使用`go get -u *****` 升级后会将新的依赖版本更新到go.mod
3. 也可以使用 `go get -u` 升级所有依赖

> 运行`go get -u`会发现一大堆很熟悉的错误，上面一大堆被墙的工具库golang.org/x/也就是我们replace的库都会报错，这说明更新是失败的，目前还不知道怎么解决这种情况。

> go get 升级

- 运行 go get -u 将会升级到最新的次要版本或者修订版本(x.y.z, z是修订版本号， y是次要版本号)
- 运行 go get -u=patch 将会升级到最新的修订版本
- 运行 go get package@version 将会升级到指定的版本号version
- 运行go get如果有版本的更改，那么go.mod文件也会更改

> 我们已经知道vendor的作用，项目成功运行起来后我们运行一下`go mod vendor`，可以发现依赖包已经加入，但不是go.sum中的所有包，是否意味着，在全新的go环境机器上下载好我们vendor后的程序，go还是会去`go: finding``go: downloading``go: extracting`各种底层包？会。花了一段时间查了一下，官方好像全下是错的，这样才是最佳实践。

> 有了vendor包也不能说明你用的是里面的包，`go build`，`go run`其实找的是`$GOPAHT/pkg/mod`下的
>
> 只有`go build -mod vendor`，`go run -mod vendor`才会用项目下的包。



#### 已使用其它包管理工具的项目迁移工作

- 直接使用init方法，可以看到go mod实现根据其它工具的配置文件去自动处理依赖

```bash
$ go mod init
go: creating new go.mod: module github.com/fusionshen/de-api
go: copying requirements from Godeps\Godeps.json
go: converting Godeps\Godeps.json: stat golang.org/x/text/secure/bidirule@342b2e1fbaa52c93f31447ad2c6abc048c63e475: unrecognized import path "golang.org/x/text/secure/bidirule" (https fetch: Get https://golang.org/x/text/secure/bidirule?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
...
```
- 这个时候生成go.mod文件是这样的
```bash
module github.com/fusionshen/dentist-expert/de-api

go 1.12

require (
	github.com/astaxie/beego v0.0.0-20190721145828-562060841891
	github.com/shiena/ansicolor v0.0.0-20151119151921-a422bbe96644
	gopkg.in/yaml.v2 v2.0.0-20190319135612-7b8349ac747c
)

```

> 然后按照上一节在go.mod添加依赖，也许会让godep和go mod在一个项目同时生效。我觉得是想太多，我也没有尝试。举个例子，虽然没啥用，但是至少告诉我们一个道理，不如移除包管理工具再进行init。

server.go 源码为：

```
package main

import (
    api "./api"  // 这里使用的是相对路径
    "github.com/labstack/echo"
)

func main() {
    e := echo.New()
    e.GET("/", api.HelloWorld)
    e.Logger.Fatal(e.Start(":1323"))
}
```

api/apis.go 源码为：

```
package api

import (
    "net/http"

    "github.com/labstack/echo"
)

func HelloWorld(c echo.Context) error {
    return c.JSON(http.StatusOK, "hello world")
}
```

1. 使用 `go mod init ***` 初始化go.mod

```
$ go mod init helloworld
go: creating new go.mod: module helloworld
```

1. 运行 `go run server.go`

```
go: finding github.com/labstack/gommon/color latest
go: finding github.com/labstack/gommon/log latest
go: finding golang.org/x/crypto/acme/autocert latest
go: finding golang.org/x/crypto/acme latest
go: finding golang.org/x/crypto latest
build command-line-arguments: cannot find module for path _/home/gs/helloworld/api
```

首先还是会查找并下载安装依赖，然后运行脚本 `server.go`，这里会抛出一个错误：

```
build command-line-arguments: cannot find module for path _/home/gs/helloworld/api
```

但是`go.mod` 已经更新：

```
$ cat go.mod
module helloworld

go 1.12

require (
    github.com/labstack/echo v3.3.10+incompatible // indirect
    github.com/labstack/gommon v0.2.8 // indirect
    github.com/mattn/go-colorable v0.1.1 // indirect
    github.com/mattn/go-isatty v0.0.7 // indirect
    github.com/valyala/fasttemplate v1.0.0 // indirect
    golang.org/x/crypto v0.0.0-20190313024323-a1f597ede03a // indirect
)
```

##### 那为什么会抛出这个错误呢？

这是因为 server.go 中使用 internal package 的方法跟以前已经不同了，由于 go.mod会扫描同工作目录下所有 package 并且`变更引入方法`，必须将 helloworld当成路径的前缀，也就是需要写成 import helloworld/api，以往 GOPATH/dep 模式允许的 import ./api 已经失效，详情可以查看这个 [issue](https://github.com/golang/go/issues/26645)。

1. 更新旧的package import 方式

所以server.go 需要改写成：

```
package main

import (
    api "helloworld/api"  // 这是更新后的引入方法
    "github.com/labstack/echo"
)

func main() {
    e := echo.New()
    e.GET("/", api.HelloWorld)
    e.Logger.Fatal(e.Start(":1323"))
}
```
## 总结

- IDE只推荐VS Code
- 传统的**GOPATH**方式现在还摆脱不了，还是要老老实实搭建本地开发环境，本本分分下载`$GOPATH/src`各种第三方包
- 新项目还是采用go mod架构，毕竟官方出品，go的发展很符合语言平和发展理念
- vendor是个好东西
- go项目都应该docker化