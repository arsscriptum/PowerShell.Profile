<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜 
#̷𝓍   𝔪𝔶 𝔭𝔯𝔦𝔳𝔞𝔱𝔢 𝔭𝔬𝔴𝔢𝔯𝔰𝔥𝔢𝔩𝔩 𝔭𝔯𝔬𝔣𝔦𝔩𝔢
#̷𝓍   
#̷𝓍   FourresTout.ps1 - All functions that need to be sorted
#̷𝓍   
#>


function Invoke-BypassPaywall{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage="url", Position=0)]
        [string]$Url,
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="option")]
        [switch]$Option        
    )
    $Global:NewTmpDir = ( (New-TemporaryDirectory).Fullname ) ; 
    pushd "$Global:NewTmpDir"
    $WgetExe = (Getcmd wget.exe).Source

    $a = @("$Url")
    Write-Host -n -f DarkRed "[BypassPaywall] " ; Write-Host -f DarkYellow "wget $WgetExe url $Url"

    $o = Invoke-Process -ExePath "$WgetExe" -ArgumentList $a 
    $i = $($o.Error).IndexOf("'")
    $j = $($o.Error).IndexOf("'", $i+1)
    $l = $($o.Error).Length
    $fn = $($o.Error).SubString($i+1, ($j-$i)-1)
    
    $fn = Join-Path "$Global:NewTmpDir" "$fn"
    $in = New-RandomFilename -Extension 'html'
    Write-Host -n -f DarkRed "[BypassPaywall] " ; Write-Host -f DarkYellow "Filename is $fn --> $in"
    mv "$fn" "$in"
    Write-Host -n -f DarkRed "[BypassPaywall] " ; Write-Host -f DarkYellow "start-process "$nf""
    popd
    rm "$Global:NewTmpDir" -Force -Recurse
    start-process "$in"
}


function Load-AllModules{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Force,
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Push        
    )
    write-host -f DarkRed "=================================================="
    write-host -f DarkRed "                    IMPORT MODULES                "
    write-host -f DarkRed "=================================================="
    pushd 'C:\DOCUMENTS\PowerShell\Module-Development\'
    $t=((gci . -Directory).Name)
    ForEach($m in $t){
        write-host -n -f DarkGreen "✅ " 
        import-module "$m" -Force -Scope 'Global' -SkipEditionCheck -DisableNameChecking
        write-host  "$m`t`t"

    }
}


function Clean-NuGetPackages{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Force,
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Push        
    )
    write-host -f DarkRed "Clean-NuGetPackages"
    pushd 'C:\DOCUMENTS\PowerShell\Module-Development\'
    $f = (gci . -File).Fullname
    ForEach($ff in $f){ rmf $ff }
}


function Build-AllModules{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Force,
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Push        
    )
    pushd 'C:\DOCUMENTS\PowerShell\Module-Development\'
    $t=((gci .).Name)
    ForEach($m in $t){pushd "$m"; make -d -i -Documentation -Publish -Push;if($Push){gpush;};popd;write-host -f DarkRed "✅ import-module $m"  ; }
    get-module
}


function Save-YoutubeVideos {
    <#
    .SYNOPSIS
        
    .DESCRIPTION
        
    .PARAMETER Path
               
    .PARAMETER Code
        
    .EXAMPLE 
       
#>

    [CmdletBinding(SupportsShouldProcess)]
    param
    (
        [ValidateScript({
        if(-Not ($_ | Test-Path) ){
            throw "File does not exist"
        }
        if(-Not ($_ | Test-Path -PathType Leaf) ){
            throw "The Path argument must be a file. Directoru paths are not allowed."
        }
        return $true 
        })]
        [Parameter(Mandatory=$true,Position=0)]
        [string]$Path,
        [Parameter(Mandatory=$true,Position=1)]
        [string]$Destination
    )
    $Null = New-Item -Path "$Destination" -ItemType Directory -Force -EA Ignore
    Push-Location "$Destination"
    $I = 0
    $yt=(getcmd youtube-dl.exe).Source
    $Content = Get-Content -Path $Path
    ForEach($Line in $Content){
        $I++
        Write-Host "----------------------"  -f DarkRed
        Write-Host "$I - Download $Line"  -f DarkYellow
        &"$yt" "$Line"
    }
    Pop-Location
}



function Invoke-PushMod{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Quiet
    )    
     moddev
     $ds = (gci -Directory ).Name
     foreach($d in $ds){
        Write-Host -n -f DarkCyan "[PushMod] ";Write-Host  -f Cyan "go in $d"
        pushd $d 
        Write-Host -n -f DarkCyan "[PushMod] ";Write-Host  -f Cyan "git push"
        $Null = gpush -Quiet:$Quiet | out-null
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
        Reset-GitRepo -q
        Write-Host -n -f DarkRed "[ResetMod] ";Write-Host  -f DarkYellow "popd"
        popd
     }
}

function Edit-HostFile{
    $HostFilePath = (Get-HostFilePath)
    Write-Host -n -f DarkRed "[Edit-HostFile] ";Write-Host  -f DarkYellow "Edit HOST at $HostFilePath"
    &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" "$HostFilePath"
}
New-Alias hostfile -Value Edit-HostFile -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope

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


function Load-AllModules{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$false, ValueFromPipeline=$true, HelpMessage="Overwrite if present", Position=0)]
        [switch]$Test
    )
    $Simulate = $Test -Or $WhatIf
    pushd 'C:\DOCUMENTS\PowerShell\Module-Development\'
    $t=((gci .).Name)
    ForEach($m in $t){
        if($Simulate){
            write-host -n -f DarkYellow "[TESTONLY] ";
            write-host "would import-module $m";
        }else{
            write-host -n -f DarkGreen "✅ ";
            write-host "import-module $m";            
            $Null=import-module $m -Force 2> Out-Null
        }
        
        
    }
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



function TypeFunction([string]$Function)
{
    $Script = (Get-Item function:$Function).ScriptBlock
    write-host -n -f DarkYellow "Function " ; 
    write-host -f DarkRed " $Function" ;
    write-host -f DarkRed "<begin>" ; 
    write-host -f DarkYellow "$Script" ;
    write-host -f DarkRed "<end>" ; 
}
function Get-LocalSigningCert{
    $Instance=dir Cert:\CurrentUser\My -CodeSigningCert | where Thumbprint -eq '5784C51A025A7E42DD96B95D8F54AA240BE4C98E'
    return $Instance
}

function SignScript([string]$Path)
{
    # https://www.darkoperator.com/blog/2013/3/5/powershell-basics-execution-policy-part-1.html
    $cert = Get-LocalSigningCert
    Write-Host "✅ Get Signing Certificate"
    $Res = Set-AuthenticodeSignature $Path -Certificate $cert 
    $Status = $Res.Status
    $StatusMessage = $Res.StatusMessage
    Write-Host "✅ Set-AuthenticodeSignature on $Path"
    Write-Host "✅ $Status"
    Write-Host "✅ $StatusMessage"
}

function New-RepositoryShortcut([string]$name)
{   
    Write-Host "✅ Go in $ENV:DevelopmentRoot"
    pushd "$ENV:DevelopmentRoot"
    New-Repository "$name" ; 
    pushd "$ENV:DevelopmentRoot\$name"
    $a=read-host 'Press (y) to invoke Invoke-GitSaveNewRepo'
    if($a -eq 'y'){
        Invoke-GitSaveNewRepo
        Write-Host "✅ Invoke-GitSaveNewRepo"
    }
    popd
    popd
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


function Invoke-GitSaveNewRepo{
    git add * ; git commit -a -m 'first' ;  git push  --set-upstream origin master
}

function Invoke-Lettoufeur{
    [CmdletBinding(SupportsShouldProcess)]
    param()
    Invoke-ExecutableAsJob "$Env:ToolsRoot\lettoufeur.exe"
}

function Invoke-ExecutableAsJob{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage="Executable path", Position=0)]
        [ValidateScript({
            if(-Not ($_ | Test-Path) ){
                throw "File or folder does not exist"
            }
            if(-Not ($_ | Test-Path -PathType Leaf) ){
                throw "The Path argument must be an executable file. Directory paths are not allowed."
            }
            return $true 
        })]        
        [string]$Path
    )    
    $Name = (Get-Item -Path $Path).Name
    Write-Host "-----------------------------------" -f DarkBlue
    Write-Host "Invoking $Name" -f Cyan
    Write-Host "-----------------------------------" -f DarkBlue
    $ScriptString =  @"
    $ExePath = `"$Path`";
    &"$ExePath";
"@

    $ScriptBlock = [scriptblock]::create($ScriptString)
    $JobData = Start-Job -Command $ScriptBlock
    $Data1 = $JobData.Id
    $Data2 = $JobData.Name
    $Data3 = $JobData.PSJobTypeName
    $Data4 = $JobData.State

    $JobName = $Base + 'JobId'
    Set-Variable -Name $JobName -Value $Data1 -Scope Global -Option readonly, allscope
    $Obj =  [PSCustomObject]@{
        Id = $Data1
        Name = $Data2
        Type = $Data3
        Status = $Data4
        JobName = $JobName
    }    
    $HashTable = ConvertTo-Json $Obj | ConvertFrom-Json -AsHashtable
    return $HashTable
}


