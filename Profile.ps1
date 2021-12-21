<#
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#>




function Get-PSProfileDevelopmentRoot{

    if($ENV:PSProfileDevelopmentRoot -ne $Null){
        if(Test-Path $ENV:PSProfileDevelopmentRoot -PathType Container){
            $PsProfileDevRoot = $ENV:PSProfileDevelopmentRoot
            return $PsProfileDevRoot
        }
    }else{
        $TmpPath = (Get-Item $Profile).DirectoryName
        $TmpPath = Join-Path $PsProfileDevRoot 'Profile'
        if(Test-Path $TmpPath -PathType Container){
            $PsProfileDevRoot = $TmpPath
            return $PsProfileDevRoot
        }

    }
    $mydocuments = [environment]::getfolderpath("mydocuments") 
    $PsProfileDevRoot = Join-Path $mydocuments 'PowerShell\Profile'
    return $PsProfileDevRoot
}

$Global:PsProfileDevRoot = Get-PSProfileDevelopmentRoot



$Tab = [char]9
$Name = $script:MyInvocation.MyCommand.Name
$i = $Name.IndexOf('.')
$Global:CurrentRunningScript  = $Name.SubString(0, $i)
$Global:ProfileErrors         = 0
$Script:ProfilePath           = (Get-Item $Profile).DirectoryName
$Script:ProfileIncPath        = Join-Path $Script:PsProfileDevRoot "private"

. "$Global:PsProfileDevRoot\PersistentFunctions.ps1"
. "$Global:PsProfileDevRoot\PersistentAliases.ps1"
    $Script:BuildDependencies = @( Get-ChildItem -Path $Script:ProfileIncPath -Filter '*.ps1' )
    $Script:DependencyCount = $Script:BuildDependencies.Count

    #Write-Host "[PROFILE] " -NoNewLine -f DarkYellow ;Write-Host "Importing build script dependencies from $Script:ProfileIncPath ($Script:DependencyCount)..." -f DarkYellow;

    #Dot source the files
    Foreach ($file in $Script:BuildDependencies) {
        Try {
            $Depname = (Get-Item -Path $file).Name
            . "$file"
            #Write-Host -f Green "[OK] " -NoNewline
            #Write-Host " + $Depname imported" -f DarkGray
        }  
        Catch {
            Write-Error -Message "Failed to import file $file $_"
        }
    }
<#
PrintCmdPromptTitle 'LOADING DEPENDENCIES' 'MODULES AND FUNCTIONS'
Import-Module $ENV:ModuleCore -Force -ErrorAction Ignore
$res=(Get-Module $ENV:ModuleCore -ErrorAction Ignore)
if($res -eq $null){ 
    Write-Warning -Message "Failed to Load $ENV:ModuleCore"
    $Global:ProfileErrors++ 
}else{
    Write-Host -f Green "[OK] " -NoNewline
    Write-Host " +  Module $ENV:ModuleCore LOADED" -f Gray
}#>

#Invoke-LoadProfileDependencies
#Register-Assemblies
#Import-CodeCastorModules
#$Update-SessionEnvironmentVariables

#Start-Job -ScriptBlock {UpdateNetInfo} | Out-null



New-Alias -name ex -Value "x"
#if($Global:ProfileErrors -eq 0){ cls }else{  Write-Host "IMPORTING DEPENDENCIES ERRORS ==> $Global:ProfileErrors" -f DarkYellow ; }
Show-Header
#Set-Transcript
Get-PowershellVersionInfo



Get-TerminalStartingDirectory -SetLocation
return 
$Notifier="C:\Programs\SystemTools\Notifier.exe"

&"$Notifier" "Windows Machine Learning for Desktop (C++) tutorial"
s "https://docs.microsoft.com/en-us/windows/ai/windows-ml/get-started-desktop"
s "https://www.youtube.com/watch?v=2FYm3GOonhk"
s "https://www.youtube.com/watch?v=8GoYXWOq55A"
s "https://www.youtube.com/watch?v=9tLWj7iOiP8"


#Get-MissionImpossible

 
