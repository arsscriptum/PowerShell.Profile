<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   PowerShell Profile
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>

function Update-FedExZip{
     remove-item 'C:\Users\radic\www\arsscriptum.github.io\PowerShell.Module.FedEx.zip' ; pushd 'C:\Users\radic\www\arsscriptum.github.io' ; push ; popd ; pushd 'C:\DOCUMENTS\PowerShell\Modules\' ; Compress-Archive .\PowerShell.Module.FedEx -DestinationPath 'C:\Users\radic\www\arsscriptum.github.io\PowerShell.Module.FedEx.zip' ;  ; pushd 'C:\Users\radic\www\arsscriptum.github.io' ; push ; popd ;
}


 function Get-PowerShellRepos{
     $Repos = @('PowerShell.Profile', 'PowerShell.Module.TakeOwnership', 'PowerShell.Module.NtRights', 'PowerShell.Module.Downloader',  'PowerShell.Module.Github', 'PowerShell.Module.Shim', 'PowerShell.Module.SetAcl', 'PowerShell.Module.WindowsHost', 'PowerShell.Persistence.ScheduledTasks', 'PowerShell.Module.Terminal', 'PowerShell.Module.FedEx', 'PowerShell.Module.Certificate', 'PowerShell.Module.Core', 'PowerShell.ModuleBuilder',  'PowerShell.Module.Reddit')
     return $Repos
 }


 function Get-XShellRepos{
     $Repos = @('exploitation-course', 'XServiceUtil', 'As-Exploits', 'X.GitProxy', 'Win32.Qt.Extension', 'X.PE-PDB.Parsers', 'X.HookLib', 'X.Ring0.SDK', 'PowerShell.Sandbox', 'XRemoteSpy', 'X.ProcessHacker', 'X.Tools', 'XSerial', 'XSerialPortUtil', 'xpk')
     return $Repos
 }


function MakePublic{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage="repo")]
        [ValidateNotNullOrEmpty()]
        [String[]]$Repos
    )
    $Repos.ForEach({ $reponame=$_; Write-Host  "- $reponame " -f DarkCyan; 
    Write-Host "PUBLIC" -f DarkGreen; 
     Set-RepositoryVisibility -Name "$reponame" -Visibility "public"
     })  
}


function Update-Downloader{
    $ModulePath = 'C:\DOCUMENTS\PowerShell\Modules\' ;
    $LocalModule = ".\PowerShell.Module.Downloader"
    $WwwRoot = 'C:\Users\radic\www\arsscriptum.github.io'
    $DeployedModule='C:\Users\radic\www\arsscriptum.github.io\PowerShell.Module.Downloader.zip' ; 
    remove-item $DeployedModule
    pushd $WwwRoot ; 
    push ; 
    popd ; 
    pushd $ModulePath 
    Compress-Archive $LocalModule -DestinationPath $DeployedModule
    pushd $WwwRoot ;
    push ; 
    popd ;
}


function Set-CompleteRepo {
     param()

    pushd "C:\Code\Win32.SimpleTelnetClient\dependency"
    $Url = "https://github.com/arsscriptum/Win32.BoostLib.161/Win32.BoostLib.161.git"
    $Path = "C:\Code\Win32.SimpleTelnetClient\dependency\boost_1_61_0"

    git submodule add $Url $Path 
}

function Load-AllModules{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Force
    )
    pushd 'C:\DOCUMENTS\PowerShell\Module-Development\'
    $t=((gci .).Name)
    ForEach($m in $t){$Null=import-module $m -Force:$Force 2> Out-Null;write-host -f DarkRed "✅ import-module $m"  ; }
    get-module
}


function Get-PSProfileDevelopmentRoot{

    if($ENV:PSProfileDevelopmentRoot -ne $Null){
        if(Test-Path $ENV:PSProfileDevelopmentRoot -PathType Container){
            $PsProfileDevRoot = $ENV:PSProfileDevelopmentRoot
            return $PsProfileDevRoot
        }
    }else{
        $TmpPath = (Get-Item $Profile).DirectoryName
        $TmpPath = Join-Path $TmpPath 'Profile'
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

. "$Global:PsProfileDevRoot\Profile.ps1"
