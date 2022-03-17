
<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   PowerShell Profile
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>

function Invoke-PushMod{
     moddev
     $ds = (gci -Directory ).Name
     foreach($d in $ds){
        Write-Host -n -f DarkCyan "[PushMod] ";Write-Host  -f Cyan "go in $d"
        pushd $d
        Write-Host -n -f DarkCyan "[PushMod] ";Write-Host  -f Cyan "git push"
        $Null = gpush | out-null
        Write-Host -n -f DarkCyan "[PushMod] ";Write-Host  -f Cyan "popd"
        popd
        
     }
}
function Invoke-ResetMod{
     moddev
     $ds = (gci -Directory ).Name
     foreach($d in $ds){
        Write-Host -n -f DarkRed "[ResetMod] ";Write-Host  -f DarkYellow "go in $d"
        pushd $d
        Write-Host -n -f DarkRed "[ResetMod] ";Write-Host  -f DarkYellow "git reset --hard"
        git reset --hard
        Write-Host -n -f DarkRed "[ResetMod] ";Write-Host  -f DarkYellow "popd"
        popd
     }
}

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


 function Invoke-FixSearch{
    mv "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.bak" "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe"
    &"C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" "-ServerName:SearchTest"
    return $?
 }

 function Invoke-BreakSearch{
    pk SearchApp
    mv "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.exe" "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy\SearchApp.bak"

    (gci "C:\Windows\SystemApps\Microsoft.Windows.Search_cw5n1h2txyewy").Name
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

function Get-CertsTest{
    cls
    $List = dir Cert:\LocalMachine\ -Recurse #| where SerialNumber -eq 43BB437D609866286DD839E1D00309F5
    Foreach($Item in $list){
        IF ($Item.SerialNumber -eq "43BB437D609866286DD839E1D00309F5") {
            write-host "Archived       :" $Item.Archived
            write-host "Extensions     :" ($Item.Extensions).Count
            write-host "Friendly Name      :" $Item.FriendlyName
            write-host "Handle             :" $Item.Handle
            write-host "HasPrivateKey      :" $Item.HasPrivateKey
            write-host "Issuer             :" $Item.Issuer
            write-host "Issuer Name        :" $Item.IssuerName
            write-host "NotAfter           :" $Item.NotAfter
            write-host "NotBefore          :" $Item.NotBefore
            write-host "PrivateKey         :" $Item.PrivateKey
            write-host "PublicKey          :" $Item.PublicKey
            write-host "RawData Lenght     :" $Item.RawData.Length
            Write-Host "Serial number      :" $Item.SerialNumber -ForegroundColor Cyan
            $Match1 = $Item.SerialNumber -match "43BB437D609866286DD839E1D00309F5"
            $Match2 = $Item.SerialNumber -match "14781bc862e8dc503a559346f5dcc518"
            if (($Match1 -eq "True") -or ($Match2 -eq "True")) {
                Write-host "Serialnumber match? Yes" -ForegroundColor Yellow
            Else {
                Write-host "Serialnumber match? No " -ForegroundColor Green
            }
            Write-host "SignatureAlgorithm :" $Item.SignatureAlgorithm
            Write-host "Subject            :" $Item.Subject
            Write-host "SubjectName        :" $Item.SubjectName
            Write-host "Thumbprint         :" $Item.Thumbprint
            Write-host "Version            :" $Item.Version
            Write-host "PSChildName        :" $Item.PSChildName
            Write-host "PSDrive            :" $Item.PSDrive
            Write-host "PSIsContainer      :" $Item.PSIsContainer
        }
    }
}
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
