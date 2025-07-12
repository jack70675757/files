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
