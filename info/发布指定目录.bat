@echo off

echo.
echo ��ָ��Ŀ¼�Ͻ���������,��: ������λ��client/clientĿ¼, ��Ϸ��λ��game/qipai/landĿ¼
echo.

set /p SRC=Ŀ¼:
if not exist "%SRC%" (
	echo ������Ϸ���Ŀ¼!
	pause.
	exit
)
rem ��ȡ��ǰĿ¼��
set curdir=""
for %%i in ("%SRC%") do (
	set curdir=%%~ni
)
set h=%time:~0,2%
set h=%h: =0%
set folder=..\client_publish\%date:~0,4%-%date:~5,2%-%date:~8,2%-%h%%time:~3,2%\%curdir%
if not exist "%folder%" (
	mkdir %folder%
)
rem ����lua����
echo ����lua����
call  cocos luacompile -s %SRC% -d %folder% -e -k RY_QP_MBCLIENT_!2016 -b RY_QP_2016 --disable-compile
if  errorlevel 1 goto CipherSrcError
if  errorlevel 0 goto MakeMD5
pause
exit

:CipherSrcError
echo ����lua����!
pause
exit

:MakeMD5
echo ����MD5�����ļ�
md ..\client\ciphercode\game
xcopy /y /e /exclude:uncopy.txt %SRC% %folder%
MakeMD5List -dst %temp% -src %folder%
copy %temp%\filemd5List.json %folder%\res\filemd5List.json
del %temp%\filemd5List.json

echo �����ļ��Ѹ��Ƶ�%folder%Ŀ¼
pause