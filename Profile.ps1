<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   PowerShell Profile
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>

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




$Tab = [char]9
$Name = $script:MyInvocation.MyCommand.Name
$i = $Name.IndexOf('.')
$Global:CurrentRunningScript  = $Name.SubString(0, $i)
$Global:ProfileErrors         = 0
$Script:ProfilePath           = (Get-Item $Profile).DirectoryName
$Script:ProfileIncPath        = Join-Path $Script:PsProfileDevRoot "private"

. "$Global:PsProfileDevRoot\PersistentFunctions.ps1"
 Write-Host "✅ $Global:PsProfileDevRoot\PersistentFunctions.ps1"
. "$Global:PsProfileDevRoot\PersistentAliases.ps1"
 Write-Host "✅ $Global:PsProfileDevRoot\PersistentAliases.ps1"
. "$Global:PsProfileDevRoot\ModuleUtils.ps1"
 Write-Host "✅ $Global:PsProfileDevRoot\ModuleUtils.ps1"
    $Script:BuildDependencies = @( Get-ChildItem -Path $Script:ProfileIncPath -Filter '*.ps1' -File ).Fullname
    $Script:DependencyCount = $Script:BuildDependencies.Count

    Write-Host "[PROFILE] " -NoNewLine -f DarkYellow ;Write-Host "Importing build script dependencies from $Script:ProfileIncPath ($Script:DependencyCount)..." -f DarkYellow;

    #Dot source the files
    Foreach ($file in $Script:BuildDependencies) {
        Try {
			Write-Host -f Green "[TRY] $file" -NoNewline
            $Depname = (Get-Item -Path $file).Name
            . "$file"
            
            
			
        }  
        Catch {
            Write-Error -Message "Failed to import file $file $_"
        }
    }


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



 
