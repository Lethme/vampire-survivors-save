@echo off
REM This is a vampire.bat file. 

REM v. 0.0.1

REM Define variables
set "GAME_DIRECTORY=S:\Games\Vaampire Survivors v1.8.208\Vampire Survivors"
set "GAME_SAVEFILE_DIRECTORY=%appdata%\Goldberg SteamEmu Saves\1794680\remote"
set "GAME_EXECUTABLE_NAME=VampireSurvivors.exe"
set "GAME_SAVEFILE_NAME=SaveData"

echo Game executable path: %GAME_DIRECTORY%
echo Game savefile path: %GAME_SAVEFILE_DIRECTORY%
echo Game executable: %GAME_EXECUTABLE_NAME%
echo.

REM Move to savefile directory
cd /D "%GAME_SAVEFILE_DIRECTORY%"

REM Define the array of commands
setlocal EnableDelayedExpansion
set commands[0]=git fetch
set commands[1]=git pull origin master
set commands[2]=cd /D "%GAME_DIRECTORY%"
set commands[3]=start "" /wait "%GAME_EXECUTABLE_NAME%"
set commands[4]=cd /D "%GAME_SAVEFILE_DIRECTORY%"
set commands[5]=git add "%GAME_SAVEFILE_NAME%"
set commands[6]=git commit -m "%GAME_SAVEFILE_NAME%_%date%%time%"
set commands[7]=git push origin master
set commands[8]=pause

REM Execute the commands one by one with "call" command
for /L %%i in (0,1,8) do (
    call %%commands[%%i]%%
)

REM Exit the script
exit