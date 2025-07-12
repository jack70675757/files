netsh int ip reset
netsh winsock reset
ipconfig /release
ipconfig /flushdns
ipconfig /renew

Write-Host "Restarting WLAN AutoConfig service..." -ForegroundColor Cyan
Restart-Service -Name "WlanSvc" -ErrorAction SilentlyContinue
Set-Service -Name "WlanSvc" -StartupType Automatic

$services = @(
    "Dhcp", "dnscache", "NlaSvc", "netprofm", "WlanSvc", "W32Time", "WaaSMedicSvc"
)

foreach ($svc in $services) {
    try {
        Set-Service -Name $svc -StartupType Automatic
        Start-Service -Name $svc
        Write-Host "$svc started and set to Automatic." -ForegroundColor Green
    } catch {
        Write-Host "Failed to start $svc" -ForegroundColor Red
    }
}

$wifiAdapter = Get-NetAdapter | Where-Object { $_.Name -match "Wi-Fi" -or $_.InterfaceDescription -match "Wireless" }

if ($wifiAdapter) {
    try {
        Enable-NetAdapter -Name $wifiAdapter.Name -Confirm:$false
        Write-Host "Enabled adapter: $($wifiAdapter.Name)" -ForegroundColor Green
    } catch {
        Write-Host "Failed to enable adapter: $($wifiAdapter.Name)" -ForegroundColor Red
    }
} else {
    Write-Host "No wireless adapter found!" -ForegroundColor Yellow
}
