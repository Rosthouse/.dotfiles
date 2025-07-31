# Importing Modules
Import-Module $env:ChocolateyInstall\helpers\chocolateyProfile.psm1
Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module PSReadLine

# Configuring oh-my-posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression

# Configuring PSReadLine
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function Complete
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView