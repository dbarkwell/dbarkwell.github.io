param ([Parameter(Mandatory = $true)][string] $Title)
$dt = Get-Date
$Title = $Title.Replace(" ", "-").ToLower()
$newFilePath = [string]::Format("{0}\_posts\{1}-{2}.md", $PSScriptRoot, $dt.ToString("yyyy-MM-dd"), $Title)
New-Item -Path $newFilePath -ItemType File | Out-Null
Add-Content $newFilePath -Value (Get-Content $PSScriptRoot\_posts\_posttemplate.txt) | Out-Null
