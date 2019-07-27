@echo 设置 App 的值为您的应用文件夹名称
set APP=fusionshen.com
REM set GOPATH=%~dp0..
set GOPATH=D:\go-work
set BEE=%GOPATH%\bin\bee
%BEE% new %APP%
cd %APP%
echo %BEE% run %APP%.exe > run.bat
REM echo %BEE% run main.go > run.bat
echo pause >> run.bat
start run.bat
pause
start http://127.0.0.1:8080