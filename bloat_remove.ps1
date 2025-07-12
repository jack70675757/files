Get-AppxPackage -AllUsers | Where-Object {
    $_.Name -like "*xbox*" -and $_.Name -notmatch "XboxGameCallableUI|GamingApp|XboxIdentityProvider"
} | ForEach-Object {
    try {
        Remove-AppxPackage -Package $_.PackageFullName -AllUsers -ErrorAction Stop
    } catch {
        Write-Host "Failed to remove $($_.Name)" -ForegroundColor DarkGray
    }
}

$apps = @(
  'Clipchamp.Clipchamp','Microsoft.3DBuilder','Microsoft.549981C3F5F10','Microsoft.BingFinance',
  'Microsoft.BingFoodAndDrink','Microsoft.BingHealthAndFitness','Microsoft.BingNews','Microsoft.BingSports',
  'Microsoft.BingTranslator','Microsoft.BingTravel','Microsoft.BingWeather','Microsoft.Copilot',
  'Microsoft.Getstarted','Microsoft.Messaging','Microsoft.Microsoft3DViewer','Microsoft.MicrosoftJournal',
  'Microsoft.MicrosoftOfficeHub','Microsoft.MicrosoftPowerBIForWindows','Microsoft.MicrosoftSolitaireCollection',
  'Microsoft.MicrosoftStickyNotes','Microsoft.MixedReality.Portal','Microsoft.NetworkSpeedTest','Microsoft.News',
  'Microsoft.Office.OneNote','Microsoft.Office.Sway','Microsoft.OneConnect','Microsoft.Print3D','Microsoft.SkypeApp',
  'Microsoft.Todos','Microsoft.WindowsAlarms','Microsoft.WindowsFeedbackHub','Microsoft.WindowsMaps',
  'Microsoft.WindowsSoundRecorder','Microsoft.ZuneVideo','MicrosoftCorporationII.MicrosoftFamily',
  'MicrosoftCorporationII.QuickAssist','MicrosoftTeams','MSTeams',
  'ACGMediaPlayer','ActiproSoftwareLLC','AdobeSystemsIncorporated.AdobePhotoshopExpress','Amazon.com.Amazon',
  'AmazonVideo.PrimeVideo','Asphalt8Airborne','AutodeskSketchBook','CaesarsSlotsFreeCasino','COOKINGFEVER',
  'CyberLinkMediaSuiteEssentials','DisneyMagicKingdoms','Disney','DrawboardPDF','Duolingo-LearnLanguagesforFree',
  'EclipseManager','Facebook','FarmVille2CountryEscape','fitbit','Flipboard','HiddenCity','HULULLC.HULUPLUS',
  'iHeartRadio','Instagram','king.com.BubbleWitch3Saga','king.com.CandyCrushSaga','king.com.CandyCrushSodaSaga',
  'LinkedInforWindows','MarchofEmpires','Netflix','NYTCrossword','OneCalendar','PandoraMediaInc','PhototasticCollage',
  'PicsArt-PhotoStudio','Plex','PolarrPhotoEditorAcademicEdition','Royal Revolt','Shazam','Sidia.LiveWallpaper',
  'SlingTV','Spotify','TikTok','TuneInRadio','Twitter','Viber','WinZipUniversal','Wunderlist','XING'
)
foreach ($app in $apps) {
    $pkgs = Get-AppxPackage -AllUsers -Name $app -ErrorAction SilentlyContinue
    foreach ($pkg in $pkgs) {
        try {
            Remove-AppxPackage -Package $pkg.PackageFullName -AllUsers -ErrorAction Stop
        } catch {
            Write-Host "Failed to remove: $($pkg.Name)" -ForegroundColor DarkGray
        }
    }
}

$services = @(
    "DiagTrack", "dmwappushservice", "MapsBroker", "RetailDemo", "RemoteRegistry",
    "Fax", "XblAuthManager", "XblGameSave", "XboxNetApiSvc", "SysMain", "WSearch"
)
foreach ($svc in $services) {
    Stop-Service -Name $svc -Force -ErrorAction SilentlyContinue
    Set-Service -Name $svc -StartupType Disabled
}

New-ItemProperty -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Search" -Name "AllowCortana" -PropertyType DWord -Value 0 -Force
New-ItemProperty -Path "HKCU:\SOFTWARE\Policies\Microsoft\Windows\Explorer" -Name "DisableSearchBoxSuggestions" -PropertyType DWord -Value 1 -Force

Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "ForegroundFlashCount" -Value 1
Set-ItemProperty -Path "HKCU:\Control Panel\Desktop\WindowMetrics" -Name "MinAnimate" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarAnimations" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewAlphaSelect" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ListviewShadow" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "FadeStartMenu" -Value 0

powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61
powercfg.exe -SETACTIVE e9a42b02-d5df-448d-aa00-03f14749eb61
