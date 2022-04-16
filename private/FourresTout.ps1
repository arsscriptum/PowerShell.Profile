<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜 
#̷𝓍   𝔪𝔶 𝔭𝔯𝔦𝔳𝔞𝔱𝔢 𝔭𝔬𝔴𝔢𝔯𝔰𝔥𝔢𝔩𝔩 𝔭𝔯𝔬𝔣𝔦𝔩𝔢
#̷𝓍   
#̷𝓍   FourresTout.ps1 - All functions that need to be sorted
#̷𝓍   
#>



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
    ForEach($m in $t){pushd "$m"; make -d -i;if($Push){gpush;};popd;write-host -f DarkRed "✅ import-module $m"  ; }
    get-module
}


function fread {
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
        [Parameter(Mandatory=$false,Position=0)]
        [Alias('f', 'p')]
        [string]$Path,
        [Parameter(Mandatory=$false,Position=1)]    
        [Alias('c')]
        [String]$Code,
        [Alias('h','?')]
        [switch]$Help
    )

    if($Help){
        $HelpStr = '
$Code = { 
    param([String]$line, [int]$index)
    Write-Host "[Read line no $index] " -f DarkRed
    Write-Host "$line" -f DarkYellow
}

 fread ".\dl.txt" -Code $Code
'   
        Write-Host "----------------------"  -f DarkRed
        Write-Host "$HelpStr"  -f DarkYellow
        Write-Host "----------------------"  -f DarkRed
        return 
    }

    $I = 0
    $SB = [ScriptBlock]::Create($Code)
    $Content = Get-Content -Path $Path
    ForEach($Line in $Content){
        $I++
        Invoke-Command -ScriptBlock $SB -ArgumentList $Line, $I
    }
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
    Write-Host "-----------------------------------" -f DarkBlue
    Write-Host "Invoking lettoufeur.exe" -f Cyan
    Write-Host "-----------------------------------" -f DarkBlue
    $ScriptString =  @'
    $EttoufeurExe = "$Env:ToolsRoot\lettoufeur.exe";
    &"$EttoufeurExe";
'@
    $ScriptBlock = [scriptblock]::create($ScriptString)
    $JobData = Start-Job -Command $ScriptBlock
    $Data1 = $JobData.Id
    $Data2 = $JobData.Name
    $Data3 = $JobData.PSJobTypeName
    $Data4 = $JobData.State
    $Obj =  [PSCustomObject]@{
        Id = $Data1
        Name = $Data2
        Type = $Data3
        Status = $Data4
    }
    Set-Variable -Name 'EttoufeurJobId' -Value $Data1 -Scope Global -Option readonly, allscope
    $HashTable = ConvertTo-Json $Obj | ConvertFrom-Json -AsHashtable
    return $HashTable
}

function Invoke-KillLettoufeur{
 Stop-Job $Global:EttoufeurJobId
}

