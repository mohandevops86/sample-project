@echo off


if "%~1"=="" goto :usage

set isValidParam=false
set deploy_target=

if "%1" == "deploy-LOCAL"  (
	set isValidParam=true
	set deploy_target=LOCAL
	set is_external=""
	set attach_jboss_webxml=false
)

if "%1" == "deploy-DV"  (
	set isValidParam=true
	set deploy_target=DV
	set is_external=""
	set attach_jboss_webxml=true
)

if "%1" == "deploy-PY"  (
	set isValidParam=true
	set deploy_target=PY
	set is_external=""
	set attach_jboss_webxml=true
)

if "%1" == "deploy-PD"  (
	set isValidParam=true
	set deploy_target=PD
	set is_external=""
	set attach_jboss_webxml=true
)

if %isValidParam% == false goto :usage

REM echo %deploy_target%
echo ant -logger org.apache.tools.ant.listener.MailLogger -Ddeploy_target=%deploy_target% %1 
ant -logger org.apache.tools.ant.listener.MailLogger -Ddeploy_target=%deploy_target%  %1
goto :eof

:usage
echo *----------------------------------------------------------------------------------------------*
echo * [Usage]: %0 ^<parameter^>                                                                    *
echo *                                                                                              *
echo * where ^<parameter^> in: deploy-LOCAL or deploy-DV or deploy-PY or deploy-PD                  *
echo *----------------------------------------------------------------------------------------------* 
exit /B 1

:eof
echo .Done
exit /B 0

