<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜 
#̷𝓍   𝔪𝔶 𝔭𝔯𝔦𝔳𝔞𝔱𝔢 𝔭𝔬𝔴𝔢𝔯𝔰𝔥𝔢𝔩𝔩 𝔭𝔯𝔬𝔣𝔦𝔩𝔢
#̷𝓍   
#̷𝓍   𝓅𝓇ℴ𝒻𝒾𝓁ℯ.𝓅𝓈1 (𝗍𝗁𝗂𝗌 𝖿𝗂𝗅𝖾) contains private profile functions
#̷𝓍   
#>


$Tab = [char]9
$Name = $script:MyInvocation.MyCommand.Name
$i = $Name.IndexOf('.')
$Global:CurrentRunningScript  = $Name.SubString(0, $i)
$Global:ProfileErrors         = 0
$Script:ProfilePath           = (Get-Item $Profile).DirectoryName
$Script:ProfileIncPath        = Join-Path $Script:PsProfileDevRoot "private"


$Script:BuildDependencies = @( Get-ChildItem -Path $Script:ProfileIncPath -Filter '*.ps1' -File ).Fullname
$Script:DependencyCount = $Script:BuildDependencies.Count

Write-Host "[PROFILE] " -NoNewLine -f DarkYellow ;Write-Host "Importing build script dependencies from $Script:ProfileIncPath ($Script:DependencyCount)..." -f DarkYellow;

#Dot source the files
Foreach ($file in $Script:BuildDependencies) {
    Try {
        $Depname = (Get-Item -Path $file).Name
        . "$file"
        Write-Host "✅ $file"
    }  
    Catch {
        Write-Host -n -f DarkRed "[error] "
        Write-Host -f DarkYellow "Failed to import file $file"
        Read-Host 'press a key ...'
    }
}

New-Alias -name ex -Value "x"
if($Global:ProfileErrors -eq 0){ cls }else{  Write-Host "IMPORTING DEPENDENCIES ERRORS ==> $Global:ProfileErrors" -f DarkYellow ; }
Show-Header
#Set-Transcript
Get-PowershellVersionInfo

Get-TerminalStartingDirectory -SetLocation
return 




 
