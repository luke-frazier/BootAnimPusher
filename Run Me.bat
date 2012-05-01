@echo off
:START
color 0a
echo                            What would you like to do?
echo.
ECHO Press 1 to push an animation.
ECHO Press 2 to restore an animation.
echo Press 3 to return to stock animation.
echo Press 4 to backup an animation. (Only use if you have already used this tool)
echo Press 5 to push a blank boot animation (Decreases boot time)
echo Press 6 to attempt to copy your phone's system animation to this folder.
echo Press 7 to preview an animation. This displays on your device.
ECHO.
SET /P M=Type a number then press ENTER. 
IF %M%==1 (GOTO PUSH)
IF %M%==2 (GOTO RESTORE)
IF %M%==3 (GOTO STOCK)
IF %M%==4 (GOTO JUSTBACKUP)
IF %M%==5 (GOTO BLANKANIM)
IF %M%==6 (GOTO PULL)
IF %M%==7 (GOTO PREVIEW)
GOTO STARTERR

:STARTERR
cls
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
ECHO Press 1 to push an animation.
ECHO Press 2 to restore an animation.
echo Press 3 to return to stock animation.
echo Press 4 to backup an animation. (Only use if you have already used this tool)
echo Press 5 to push a blank boot animation (Decreases boot time)
echo Press 6 to attempt to copy your phone's system animation to this folder.
echo Press 7 to preview your current animation. This displays on your device.
ECHO.
SET /P M=Type a number then press ENTER. 
IF %M%==1 GOTO PUSH
IF %M%==2 GOTO RESTORE
IF %M%==3 GOTO STOCK
IF %M%==4 GOTO JUSTBACKUP
IF %M%==5 GOTO BLANKANIM
IF %M%==6 GOTO PULL
IF %M%==7 GOTO PREVIEW
GOTO STARTERR

:PUSH
cls
color 0b
echo           ***********************************************************
echo           *            Welcome to the boot animation pusher.        *
echo           *                      Made by trter10                    *
echo           *           No root required thanks to user migan95!      *
echo           * Don't worry, we back up your old one! (If you have one) *
echo           ***********************************************************
echo.
echo    Please have your boot animation file in the folder that this .bat is in
echo                        and name it bootanimation.zip.
echo.
echo                     Also ensure "USB Debugging" is enabled.
echo.
echo                            Press enter when ready.
echo.
pause >NUL
echo          Do you want to backup your custom animation? (If you have one)
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO PUSHBACKUP) ELSE (if %M%==2 (GOTO PUSHCONTINUE) ELSE (GOTO PUSHERR))

:PUSHERR
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo          Do you want to backup your custom animation? (If you have one)
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO PUSHBACKUP) ELSE (if %M%==2 (GOTO PUSHCONTINUE) ELSE (GOTO PUSHERR))

:PUSHCONTINUE
echo.
echo                             Searching for device...
echo.
support_files\adb wait-for-device
echo                                     Found!
echo.
support_files\adb push bootanimation.zip /data/local
echo                                     DONE!
echo.
GOTO REBOOT

:PUSHBACKUP
echo.
echo                             Searching for device...
support_files\adb wait-for-device
echo                                     Found!
echo.
set choice=
set /p choice=What do you wish to name your backup? 
support_files\adb pull /data/local/bootanimation.zip Bootanimationbackup\%CHOICE%.zip
support_files\adb push bootanimation.zip /data/local
echo                                     DONE!
echo      Your old boot animation is saved to the BootanimationBackup folder.
echo.
GOTO REBOOT

:RESTORE
cls
color 04
echo                   ********************************************
echo                   *  Welcome to the boot animation restorer. *
echo                   *             Made by trter10              *
echo                   * No root required thanks to user migan95! *
echo                   ********************************************
echo.
echo                    Please ensure "USB Debugging" is enabled.
echo.
echo                             Press enter when ready.
pause >NUL
echo.
echo         Do you want to backup your custom animation? (If you have one)
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO BACKUP2) ELSE (if %M%==2 (GOTO CONTINUE2) ELSE (GOTO RestoreERR)

:RestoreERR
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo         Do you want to backup your custom animation? (If you have one)
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO BACKUP2) ELSE (if %M%==2 (GOTO CONTINUE2) ELSE (GOTO RestoreERR)

:BACKUP2
echo.
echo                              Searching for device...
echo.
support_files\adb wait-for-device
echo                                     Found!
echo.
set choice=
set /p choice=What do you wish to name your backup? 
support_files\adb pull /data/local/bootanimation.zip Bootanimationbackup\%CHOICE%.zip
echo.
set choice=
set /p choice=What is the name of the backup you want to restore? (Do not include .zip) 
IF EXIST BootanimationBackup\%CHOICE%.zip (support_files\adb push BootanimationBackup\%CHOICE%.zip /data/local/bootanimation.zip) ELSE (GOTO NOEXIST1)
echo.
echo                                     DONE!
echo       Your old boot animation is saved to the BootanimationBackup folder.
pause >NUL
exit

:NOEXIST1
echo.
echo.
echo.
echo The file you specified does not exist.
echo.
set choice=
set /p choice=What is the name of the backup you want to restore? (Do not include .zip) 
IF EXIST BootanimationBackup\%CHOICE%.zip (support_files\adb push BootanimationBackup\%CHOICE%.zip /data/local/bootanimation.zip) ELSE (GOTO NOEXIST1)
echo.
echo                                     DONE!
echo      Your old boot animation is saved to the BootanimationBackup folder.
GOTO REBOOT

:CONTINUE2
echo.
echo                             Searching for device...
echo.
support_files\adb wait-for-device
echo                                     Found!
set choice=
set /p choice=What is the name of the backup you want to restore? (Do not include .zip) 
IF EXIST BootanimationBackup\%CHOICE%.zip (support_files\adb push BootanimationBackup\%choice%.zip /data/local/bootanimation.zip) ELSE (GOTO NOEXIST)
echo.
echo                                     DONE!
GOTO REBOOT

:NOEXIST
echo.
echo.
echo.
echo The file you specified does not exist.
echo.
set choice=
set /p choice=What is the name of the backup you want to restore? (Do not include .zip) 
IF EXIST BootanimationBackup\%CHOICE%.zip (support_files\adb push BootanimationBackup\%choice%.zip /data/local/bootanimation.zip) ELSE (GOTO NOEXIST)
echo.
echo                                     DONE!
GOTO REBOOT

:STOCK
cls
color 02
echo                   ********************************************
echo                   *   Welcome to the return to stock tool.   *
echo                   *             Made by trter10              *
echo                   * No root required thanks to user migan95! *
echo                   ********************************************
echo.
echo                     Please ensure "USB Debugging" is enabled.
echo.
echo                              Press enter when ready.
pause >NUL
echo.
echo               Do you want to backup your current custom animation?
echo.
set /p m=Press 1 for yes or 2 for no. 
IF %M%==1 (GOTO BACKUP) ELSE (IF %M%==2 (GOTO CONTINUE) ELSE (GOTO STOCKERR))

:STOCKERR
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo               Do you want to backup your current custom animation?
echo.
set /p m=Press 1 for yes or 2 for no. 
IF %M%==1 (GOTO BACKUP) ELSE (IF %M%==2 (GOTO CONTINUE) ELSE (GOTO STOCKERR))

:CONTINUE
echo.
echo                             Searching for device...
support_files\adb wait-for-device
echo                                     Found!
echo.
support_files\adb shell rm /data/local/bootanimation.zip
echo.
echo                                      DONE!
GOTO REBOOT

:BACKUP
echo.
echo                              Searching for device...
support_files\adb wait-for-device
echo                                     Found!
echo.
set choice=
set /p choice=What do you wish to name your backup? 
support_files\adb pull /data/local/bootanimation.zip \BootanimationBackup\%CHOICE%.zip
support_files\adb shell rm /data/local/bootanimation.zip
echo.
echo                                      DONE!
echo      Your old boot animation is saved to the BootanimationBackup folder.
GOTO REBOOT

:JUSTBACKUP
cls
color 0e
echo                ***********************************************
echo                *  Welcome to the boot animation backup tool. *
echo                *               Made by trter10               *
echo                *   No root required thanks to user migan95!  *
echo                ***********************************************
echo.
echo                    Please ensure "USB Debugging" is enabled.
echo.
echo                            Press enter when ready.
pause >NUL
echo.
echo                             Searching for device...
echo.
support_files\adb wait-for-device
echo                                     Found!
set choice=
set /p choice=What do you wish to name your backup? 
support_files\adb pull /data/local/bootanimation.zip Bootanimationbackup\%CHOICE%.zip
echo.
echo                                      DONE!
pause >NUL
exit

:BLANKANIM
cls
color 07
echo                ***********************************************
echo                *  Welcome to the blank boot animation tool.  *
echo                *               Made by trter10               *
echo                *   No root required thanks to user migan95!  *
echo                ***********************************************
echo.
echo                    Please ensure "USB Debugging" is enabled.
echo.
echo                            Press enter when ready.
pause >NUL
echo.
echo         Do you want to backup your custom animation (If you have one)?
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO BACKUP3) ELSE (if %M%==2 (GOTO CONTINUE3) ELSE (GOTO BLANKANIMERR))

:BLANKANIMERR
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo         Do you want to backup your custom animation (If you have one)?
echo.
set /p m=Press 1 for yes or 2 for no. 
if %M%==1 (GOTO BACKUP3) ELSE (if %M%==2 (GOTO CONTINUE3) ELSE (GOTO BLANKANIMERR))

:BACKUP3
echo                             Searching for device...
echo.
support_files\adb wait-for-device
echo                                     Found!
set choice=
set /p choice=What do you wish to name your backup? 
support_files\adb pull /data/local/bootanimation.zip Bootanimationbackup\%CHOICE%.zip
support_files\adb push support_files\BlankAnim.zip /data/local/bootanimation.zip
echo.
echo                                      DONE!
echo      Your old boot animation is saved to the BootanimationBackup folder.
exit

:CONTINUE3
echo                               Searching for device...
echo.
support_files\adb wait-for-device
echo                                      Found!
support_files\adb push support_files\BlankAnim.zip /data/local/bootanimation.zip
echo.
echo                                       DONE!
GOTO REBOOT

:PULL
cls
color 06
echo                  ***********************************************
echo                  *   Welcome to the boot animation pull tool.  *
echo                  *               Made by trter10               *
echo                  ***********************************************
echo.
echo    This only works if your phone's system boot animation is in /system/media
echo.
echo                     Please ensure "USB Debugging" is enabled.
echo.
echo                              Press enter when ready.
pause >NUL
echo.
echo                              Searching for device...
echo.
support_files\adb wait-for-device
echo                                      Found!
support_files\adb pull system/media/bootanimation.zip SYSTEMbootanimation.zip
echo.
echo                                       DONE!
echo.
pause
exit

:PREVIEW
cls
color 08
echo                  ***********************************************
echo                  * Welcome to the boot animation preview tool. *
echo                  *               Made by trter10               *
echo                  ***********************************************
echo.
echo Is the animation you want to test already on the device or on the computer?
set /p M=Press 1 for device or 2 for computer. 
IF %M%==1 (GOTO PrevDevice) ELSE (IF %M%==2 (GOTO PrevComp) ELSE (goto PREVIEWERR))

:PREVIEWERR
echo.
echo.
echo.
echo You have pressed an incorrect key.
echo.
echo Is the animation you want to test already on the device or on the computer?
set /p M=Press 1 for device or 2 for computer. 
IF %M%==1 (GOTO PrevDevice) ELSE (IF %M%==2 (GOTO PrevComp) ELSE (GOTO PREVIEWERR))

:PrevDevice
echo.
echo Plese have your device in the standard orientation so this displays properly.
echo                              Press enter when ready.
pause >NUL
echo.
echo                              Searching for device...
echo.
support_files\adb wait-for-device 
echo                                      Found!
echo.
echo Your boot animation is now playing. Close this dialog box When you are done.
support_files\adb shell bootanimation > support_files\a.log
del support_files\a.log
pause >NUL

:PrevComp
echo.
echo    Make sure it's in the folder this .bat is in and named bootanimation.zip
echo.
echo                             Press enter when ready.
pause >NUL
echo.
echo                              Searching for device...
echo.
support_files\adb wait-for-device 
echo                                      Found!
echo.
support_files\adb pull /data/local/bootanimation.zip support_files\ba.zip
support_files\adb push bootanimation.zip /data/local
start support_files\prevanim.bat
support_files\adb shell bootanimation > support_files\a.log
del support_files\a.log

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
