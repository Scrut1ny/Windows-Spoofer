@echo off
setlocal EnableDelayedExpansion


:: ====================================================================================================
:: Request Administrator Privileges
:: ====================================================================================================

fltmc >nul 2>&1 || (
    echo( && echo   [33m# Administrator privileges are required. && echo([0m
    PowerShell Start -Verb RunAs '%0' 2> nul || (
        echo   [33m# Right-click on the script and select "Run as administrator".[0m
        >nul pause && exit 1
    )
    exit 0
)

:: ====================================================================================================


:: ====================================================================================================
:: AMIBIOS DMI EDITOR
::
:: If you get any errors relating to PNP your motherboard isn't compatible with this version of AMIBIOS DMI EDITOR.
:: Some motherboards aren't compatible spoofing with this software.
:: ====================================================================================================

>nul 2>&1 bcdedit ^| find "nointegritychecks"
IF %ERRORLEVEL% EQU 0 (
	echo   # nointegritychecks: Enabled!
) ELSE (
	>nul 2>&1 (
		rem Disable Windows Signature Enforcement
		bcdedit /set nointegritychecks on
		shutdown /f /r /t 0
		exit
	)
)

>nul 2>&1 (
	pushd "%tmp%"
	
	if exist "%tmp%\AMIDEWINx64.EXE" (
		rem File exists.
	) else (
		curl -A "Mozilla/5.0" -fksLo "%tmp%\dmi-edit-win64-ami.zip" "https://download.schenker-tech.de/package/dmi-edit-efi-ami/?wpdmdl=3997&ind=1647077068432&filename=dmi-edit-win64-ami.zip" && tar -xf "%tmp%\dmi-edit-win64-ami.zip"
	)
	
	rem System Information - Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic path win32_computersystemproduct get IdentifyingNumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if /i "%%B"=="To be Filled by O.E.M." (
				echo String matches "To be Filled by O.E.M." 
			) else if /i "%%B"=="Unknown" (
				echo String matches "Unknown"
			) else (
				call :RSG
				"%tmp%\AMIDEWINx64.EXE" /SS "!string!"
			)
		)
	)
	rem System Information - UUID
	"%tmp%\AMIDEWINx64.EXE" /SU AUTO

	rem Base Board/Module Information - Baseboard Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic path win32_BaseBoard get SerialNumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if /i "%%B"=="To be Filled by O.E.M." (
				echo String matches "To be Filled by O.E.M." 
			) else if /i "%%B"=="Unknown" (
				echo String matches "Unknown"
			) else (
				call :RSG
				"%tmp%\AMIDEWINx64.EXE" /BS "!string!"
			)
		)
	)

	rem System Enclosure or Chassis - Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic path win32_systemenclosure get serialnumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if /i "%%B"=="To be Filled by O.E.M." (
				echo String matches "To be Filled by O.E.M." 
			) else if /i "%%B"=="Unknown" (
				echo String matches "Unknown"
			) else (
				call :RSG
				"%tmp%\AMIDEWINx64.EXE" /CS "!string!"
			)
		)
	)
	
	rem Processor Information - Serial Number
	for /f "tokens=2 delims==" %%A in ('wmic path win32_processor get serialnumber /value ^| find "="') do (
		for /f "delims=" %%B in ("%%~A") do (
			if /i "%%B"=="To be Filled by O.E.M." (
				echo String matches "To be Filled by O.E.M." 
			) else if /i "%%B"=="Unknown" (
				echo String matches "Unknown"
			) else (
				call :RSG
				"%tmp%\AMIDEWINx64.EXE" /PSN "!string!"
			)
		)
	)

	rem Memory Device - Serial Number
	
	
	rem Delete remaining files
	del /F /Q "%tmp%\*"
)

rem Enable Windows Signature Enforcement
bcdedit /set nointegritychecks off

:: ====================================================================================================


:: ====================================================================================================
:: 20 Digit long "A-Z, 0-9" random string generator
:: ====================================================================================================

:RSG
set "char=ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
set "char_length=36"
set "length=20"
set "string="

for /L %%a in (1,1,!length!) do (
    set /A "index=!random! %% !char_length!"
    for %%b in (!index!) do set "string=!string!!char:~%%b,1!"
)

exit /b 0

:: ====================================================================================================