# go开发环境配置

* ## Win10
   1. 开发包安装
      * go老版本请先卸载。
      * Windows 下可以使用 .msi安装包来安装[安装包地址](https://golang.org/dl/)，当前版本go1.12.7.windows-amd64.msi，选择默认, 文件会安装在 c:\Go 目录下。
   
   2. 环境变量
  安装后会自动配置相关环境变量，win10中搜索框输入***env***可快速呼出环境变量，系统变量Path会自动添加%GOROOT%\bin和C:\Go\bin。其中GOROOT就是指向c:\\Go, 可在git-bash中输入go env GOROOT查看。
    
   3. 工作目录
        我的理解：工作目录就是在本机保证整个go代码生态的文件夹，不是项目级别，而是整个语言级别的包管理模式。
     
      * 新建工作目录文件夹，本人为D:\go-work。
      * 环境变量中的用户变量和系统变量添加GOPATH: D:\go-work,可在git-bash中输入go env GOPATH查看。
      * 我还在用户变量Path中添加了%GOPATH%\bin，这个可以确保全局执行install后的exe。
      * 记住要重启机器！
      * 还需要在工作目录中手建src文件夹，这里会存放所有代码，bin和pkg在某些操作后会自动生成。
        
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
          |   |   |-- dentist-expert
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
        
         **Tips**: 关于tree命令的添加可以查看[git-bash tree](https://blog.csdn.net/t3369/article/details/80517097)。
        
      * go get -v -u github.com/XXX/XXX就是获取第三方库的命令行方式，全局使用，go会自动将其安装到工作目录的相应目录。

   4. 初次写helloworld会提示安装gocode插件安装，点击安装会一直报错，解决方案如下：
      ```bash
      gocode:
      Error: Command failed: /c/go/bin/go get -u -v github.com/mdempsky/gocode
github.com/mdempsky/gocode (download)
Fetching https://golang.org/x/tools/go/gcexportdata?go-get=1
https fetch failed: Get https://golang.org/x/tools/go/gcexportdata?go-get=1: dial tcp 216.239.37.1:443: i/o timeout
package golang.org/x/tools/go/gcexportdata: unrecognized import path "golang.org/x/tools/go/gcexportdata" (https fetch: Get https://golang.org/x/tools/go/gcexportdata?go-get=1: dial tcp 216.239.37.1:443: i/o timeout)
      ```
      * 请确保自己正在科学上网。
      * 即使是科学上网也会提示上述错误，总结说来是因为本机没有golang.org工具源码。
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
            ```
         3. 通过tree值可查看到golang.org中的三个工具包
      
   5. 开始安装VSCode依赖的几款工具，包括上面提到的gocode，如果失败多试几次，成功后src下的目录结构就如同tree相似
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
      
   6. 安装工具，执行成功后就是tree中的bin目录结构了
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
  
   7. 调试
      如上图工具介绍可知，dlv是调试的工具，支持单步调试的功能，经本机测试确实能够实现，由此可知，vsc就是利用第三方工具手动组装成IDE。
      ```
      go get -v -u github.com/peterh/liner github.com/derekparker/delve/cmd/dlv
      ```
   8. 工作区设置
      * .vscode/settings.json
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
      * .vscode/launch.json
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
      


* ## Mac
	[VSC环境](https://www.jianshu.com/p/f952042af8ff)