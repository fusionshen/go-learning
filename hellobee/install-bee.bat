REM set GOPATH=%~dp0..
set GOPATH=D:\go-work
go build github.com\beego\bee
copy bee.exe %GOPATH%\bin\bee.exe
del bee.exe
pause