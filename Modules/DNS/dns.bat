@echo off


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
:: DNS
:: ====================================================================================================

:: Setting DNS servers to: "Quad9" (Bypass ISP censorship and tracking.)

>nul 2>&1 (
	for /f "skip=2 tokens=2 delims=," %%A in ('wmic nic where NetEnabled^=True get NetConnectionID /format:csv') do (
		for /f "delims=" %%B in ("%%A") do (
			netsh interface ipv4 set dnsservers "%%B" static "9.9.9.9" primary
			netsh interface ipv4 add dnsservers "%%B" "149.112.112.112" index=2
			netsh interface ipv6 set dnsservers "%%B" static "2620:fe::fe" primary
			netsh interface ipv6 add dnsservers "%%B" "2620:fe::9" index=2
		)
	)
	ipconfig /flushdns
)

:: ====================================================================================================