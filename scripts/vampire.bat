@echo off
REM This is a vampire.bat file. 

REM v. 0.0.2

REM Define variables
set "GAME_DIRECTORY=S:\Games\Vaampire Survivors v1.8.208\Vampire Survivors"
set "GAME_SAVEFILE_DIRECTORY=%appdata%\Goldberg SteamEmu Saves\1794680\remote"
set "GAME_EXECUTABLE_NAME=VampireSurvivors.exe"
set "GAME_SAVEFILE_NAME=SaveData"
set "GAME_LOCKFILE_NAME=Bromfile"

echo Game executable path: %GAME_DIRECTORY%
echo Game savefile path: %GAME_SAVEFILE_DIRECTORY%
echo Game executable: %GAME_EXECUTABLE_NAME%
echo.

REM Move to savefile directory
cd /D "%GAME_SAVEFILE_DIRECTORY%"

REM Prefetching save files from remote git repository
call git fetch
call git pull origin master

REM Check for lock file existence
if exist %GAME_LOCKFILE_NAME% (
	echo Another user is playing the game now.
	echo Try to run this script a little bit later.
	
	pause
	exit
) else (
	REM Creating game lock file
	echo > %GAME_LOCKFILE_NAME%

	REM Pushing game lock file to remote git repository
	call git add %GAME_LOCKFILE_NAME%
	call git commit -m "%GAME_LOCKFILE_NAME%_%date%%time%"
	call git push origin master
)

REM Define the array of commands
setlocal EnableDelayedExpansion
set commands[0]=cd /D "%GAME_DIRECTORY%"
set commands[1]=start "" /wait "%GAME_EXECUTABLE_NAME%"
set commands[2]=cd /D "%GAME_SAVEFILE_DIRECTORY%"
set commands[3]=git rm "%GAME_LOCKFILE_NAME%"
set commands[4]=git add "%GAME_SAVEFILE_NAME%"
set commands[5]=git commit -m "%GAME_SAVEFILE_NAME%_%date%%time%"
set commands[6]=git push origin master
set commands[7]=pause

REM Execute the commands one by one with "call" command
for /L %%i in (0,1,7) do (
    call %%commands[%%i]%%
)

REM Exit the script
exit