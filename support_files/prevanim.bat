@echo off
color 08
echo.
echo.
echo Your animation is now playing. Close the other dialog box When you are done.
echo.
echo.
echo.
echo Do you want to push the animation you just previewed?
set /p M=Press 1 for yes or 2 to exit. 
IF %M%==1 (GOTO PushPrev) ELSE (IF %M%==2 (GOTO RevertPrev) ELSE (GOTO PrevAnimErr))

:PrevAnimErr
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo Do you want to push the animation you just previewed?
set /p M=Press 1 for yes or 2 to exit. 
IF %M%==1 (GOTO PushPrev) ELSE (IF %M%==2 (GOTO RevertPrev) ELSE (GOTO PrevAnimErr))

:PushPrev
echo.
echo           Do you want to backup your custom animation (If you have one)?
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO MoveBackupForPreview) ELSE (if %M%==2 (GOTO RemoveBackupForPreview) ELSE (GOTO PushPrevErr))

:PushPrevErr
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo           Do you want to backup your custom animation (If you have one)?
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO MoveBackupForPreview) ELSE (if %M%==2 (GOTO RemoveBackupForPreview) ELSE (GOTO PushPrevErr))

:MoveBackupForPreview
echo.
set choice=
set /p choice=What do you wish to name your backup? 
move support_files\ba.zip BootanimationBackup\%CHOICE%.zip
echo.
echo                                      DONE!
echo.
echo Do you want to reboot?
echo Press 1 for yes or 2 for no.
IF %M%==1 (support_files\adb reboot) ELSE (IF %M%==2 (exit) ELSE (GOTO MBFPERR))

:MBFPERR
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo Do you want to reboot?
echo Press 1 for yes or 2 for no.
IF %M%==1 (support_files\adb reboot) ELSE (IF %M%==2 (exit) ELSE (GOTO MBFPERR))

:RemoveBackupForPreview
echo.
del support_files\ba.zip >NUL

:RevertPrev
echo.
support_files\adb shell rm /data/local/bootanimation.zip
support_files\adb push support_files\ba.zip /data/local
del support_files\ba.zip >NUL

:REBOOT
echo.
echo Do you want to reboot?
set /p M=Press 1 for yes or 2 for no. 
IF %M%==1 (support_files\adb reboot) ELSE (IF %M%==2 (exit) ELSE (GOTO REBOOTFAIL))
exit

:REBOOTFAIL
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo Do you want to reboot?
set /p M=Press 1 for yes or 2 for no. 
IF %M%==1 (support_files\adb reboot) ELSE (IF %M%==2 (exit) ELSE (GOTO REBOOTFAIL))
