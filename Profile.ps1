<#
#Μ·π   ππ‘π’ π’ππ‘πππ£π€π 
#Μ·π   πͺπΆ π­π―π¦π³ππ±π’ π­π¬π΄π’π―π°π₯π’π©π© π­π―π¬π£π¦π©π’
#Μ·π   
#Μ·π   ππβ΄π»πΎπβ―.ππ1 (ππππ πΏπππΎ) contains private profile functions
#Μ·π   
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
        Write-Host "β $file"
    }  
    Catch {
        Write-Host -n -f DarkRed "[error] "
        Write-Host -f DarkYellow "Failed to import file $file"
        Read-Host 'press a key ...'
    }
}


$AlTest = Get-Alias 'makeprod' -ErrorAction Ignore
if($AlTest -eq $Null){
     modbuild ; .\Setup.ps1 -Alias ; popd
}

New-Alias -name ex -Value "x"
if($Global:ProfileErrors -eq 0){ cls }else{  Write-Host "IMPORTING DEPENDENCIES ERRORS ==> $Global:ProfileErrors" -f DarkYellow ; }
Show-Header
#Set-Transcript
Get-PowershellVersionInfo

Get-TerminalStartingDirectory -SetLocation
return 




 
