:: ------- Self-elevating.bat --------------------------------------
@whoami /groups | find "S-1-16-12288" > nul && goto :admin
set "ELEVATE_CMDLINE=cd /d "%~dp0" & call "%~f0" %*"
findstr "^:::" "%~sf0">temp.vbs
cscript //nologo temp.vbs & del temp.vbs & exit /b

::: Set objShell = CreateObject("Shell.Application")
::: Set objWshShell = WScript.CreateObject("WScript.Shell")
::: Set objWshProcessEnv = objWshShell.Environment("PROCESS")
::: strCommandLine = Trim(objWshProcessEnv("ELEVATE_CMDLINE"))
::: objShell.ShellExecute "cmd", "/c " & strCommandLine, "", "runas"
:admin -------------------------------------------------------------
:: MSYS_NO_PATHCONV=1 cmd /c self-elevating.bat C:/Windows/System32/Drivers/etc/hosts
@echo off
echo Running as elevated user.
echo Script file : %~f0
echo Arguments   : %*
echo Working dir : %cd%
echo.
:: administrator commands here
hostctl\hostctl.exe %*
::hostctl/hostctl.exe %*
:: e.g., run shell as admin