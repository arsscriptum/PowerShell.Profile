<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   PowerShell Profile
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>



#===============================================================================
# TEMPLATE FUNCTION
#===============================================================================

<#
## Microsoft Function Script:Naming Convention: http://msdn.microsoft.com/en-us/library/ms714428(v=vs.85).aspx
Function Script:Verb-Noun {
33####
. SYNOPSIS
. DESCRIPTION
. PARAMETER
. EXAMPLE
. NOTES
. LINK

####3>
    [CmdletBinding()]
    Param (
    )
    
    Begin {
        ## Get the name of this Function Script:and write header
        [string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
        Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header
    }
    Process {
        Try {
            
        }
        Catch {
            Write-Log -Message "<error message>. `n$(Resolve-Error)" -Severity 3 -Source ${CmdletName}
        }
    }
    End {
        Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -Footer
    }
}
#>

class ChannelProperties
{
    #ChannelProperties
    [string]$Channel = 'ProfilePersistentFunct'
    [ConsoleColor]$TitleColor = 'Blue'
    [ConsoleColor]$MessageColor = 'DarkGray'
    [ConsoleColor]$ErrorColor = 'DarkRed'
    [ConsoleColor]$SuccessColor = 'DarkGreen'
    [ConsoleColor]$ErrorDescriptionColor = 'DarkYellow'
}
$Script:ChannelProps = [ChannelProperties]::new()


$Colors = @('AliceBlue' , 'AntiqueWhite' , 'Aqua' , 'Aquamarine' , 'Azure' , 'Beige' , 'Bisque' , 'Black' , 'BlanchedAlmond' , 'Blue' , 'BlueViolet' , 'Brown' , 'BurlyWood' , 'CadetBlue' , 'Chartreuse' , 'Chocolate' , 'Coral' , 'CornflowerBlue' , 'Cornsilk' , 'Crimson' , 'Cyan' , 'DarkBlue' , 'DarkCyan' , 'DarkGoldenrod' , 'DarkGray' , 'DarkGreen' , 'DarkKhaki' , 'DarkMagenta' , 'DarkOliveGreen' , 'DarkOrange' , 'DarkOrchid' , 'DarkRed' , 'DarkSalmon' , 'DarkSeaGreen' , 'DarkSlateBlue' , 'DarkSlateGray' , 'DarkTurquoise' , 'DarkViolet' , 'DeepPink' , 'DeepSkyBlue' , 'DimGray' , 'DodgerBlue' , 'Firebrick' , 'FloralWhite' , 'ForestGreen' , 'Fuchsia' , 'Gainsboro' , 'GhostWhite' , 'Gold' , 'Goldenrod' , 'Gray' , 'Green' , 'GreenYellow' , 'Honeydew' , 'HotPink' , 'IndianRed' , 'Indigo' , 'Ivory' , 'Khaki' , 'Lavender' , 'LavenderBlush' , 'LawnGreen' , 'LemonChiffon' , 'LightBlue' , 'LightCoral' , 'LightCyan' , 'LightGoldenrodYellow' , 'LightGray' , 'LightGreen' , 'LightPink' , 'LightSalmon' , 'LightSeaGreen' , 'LightSkyBlue' , 'LightSlateGray' , 'LightSteelBlue' , 'LightYellow' , 'Lime' , 'LimeGreen' , 'Linen' , 'Magenta' , 'Maroon' , 'MediumAquamarine' , 'MediumBlue' , 'MediumOrchid' , 'MediumPurple' , 'MediumSeaGreen' , 'MediumSlateBlue' , 'MediumSpringGreen' , 'MediumTurquoise' , 'MediumVioletRed' , 'MidnightBlue' , 'MintCream' , 'MistyRose' , 'Moccasin' , 'NavajoWhite' , 'Navy' , 'OldLace' , 'Olive' , 'OliveDrab' , 'Orange' , 'OrangeRed' , 'Orchid' , 'PaleGoldenrod' , 'PaleGreen' , 'PaleTurquoise' , 'PaleVioletRed' , 'PapayaWhip' , 'PeachPuff' , 'Peru' , 'Pink' , 'Plum' , 'PowderBlue' , 'Purple' , 'Red' , 'RosyBrown' , 'RoyalBlue' , 'SaddleBrown' , 'Salmon' , 'SandyBrown' , 'SeaGreen' , 'SeaShell' , 'Sienna' , 'Silver' , 'SkyBlue' , 'SlateBlue' , 'SlateGray' , 'Snow' , ' SpringGreen' , 'SteelBlue' , 'Tan' , 'Teal' , 'Thistle' , 'Tomato' , 'Transparent' , 'Turquoise' , 'Violet' , 'Wheat' , 'White' , 'WhiteSmoke' , 'Yellow' , 'YellowGreen')

Function Update-SessionEnvironmentVariables {
<#
.SYNOPSIS
    Updates the environment variables for the current PowerShell session with any environment variable changes that may have occurred during script execution.
.DESCRIPTION
    Environment variable changes that take place during script execution are not visible to the current PowerShell session.
    Use this Function Script:to refresh the current PowerShell session with all environment variable settings.
.PARAMETER LoadLoggedOnUserEnvironmentVariables
    If script is running in SYSTEM context, this option allows loading environment variables from the active console user. If no console user exists but users are logged in, such as on terminal servers, then the first logged-in non-console user.
.PARAMETER ContinueOnError
    Continue if an error is encountered. Default is: $true.
.EXAMPLE
    Update-SessionEnvironmentVariables
.NOTES
    This Function Script:has an alias: Refresh-SessionEnvironmentVariables
.LINK
    http://psappdeploytoolkit.com
#>
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [switch]$LoadLoggedOnUserEnvironmentVariables = $false,
        [Parameter(Mandatory=$false)]
        [ValidateNotNullOrEmpty()]
        [boolean]$ContinueOnError = $true
    )

    Begin {
        ## Get the name of this Function Script:and write header
        [string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name

        [scriptblock]$GetEnvironmentVar = {
            Param (
                $Key,
                $Scope
            )
            [Environment]::GetEnvironmentVariable($Key, $Scope)
        }
    }
    Process {
        Try {
            Write-Host 'Refreshing the environment variables for this PowerShell session.'

            If ($LoadLoggedOnUserEnvironmentVariables -and $RunAsActiveUser) {
                [string]$CurrentUserEnvironmentSID = $RunAsActiveUser.SID
            }
            Else {
                [string]$CurrentUserEnvironmentSID = [Security.Principal.WindowsIdentity]::GetCurrent().User.Value
            }
            [string]$MachineEnvironmentVars = 'Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Session Manager\Environment'
            [string]$UserEnvironmentVars = "Registry::HKEY_USERS\$CurrentUserEnvironmentSID\Environment"

            ## Update all session environment variables. Ordering is important here: $UserEnvironmentVars comes second so that we can override $MachineEnvironmentVars.
            $MachineEnvironmentVars, $UserEnvironmentVars | Get-Item | ForEach-Object { if($_){$envRegPath = $_.PSPath; $_.Property | ForEach-Object { Set-Item -LiteralPath "env:$($_)" -Value (Get-ItemProperty -LiteralPath $envRegPath -Name $_).$_ } } }

            ## Set PATH environment variable separately because it is a combination of the user and machine environment variables
            [string[]]$PathFolders = 'Machine', 'User' | ForEach-Object { $EachPathFolder = (& $GetEnvironmentVar -Key 'PATH' -Scope $_); if($EachPathFolder){ $EachPathFolder.Trim(';').Split(';').Trim().Trim('"') } } | Select-Object -Unique
            $env:PATH = $PathFolders -join ';'
        }
        Catch {
            Write-Host "Failed to refresh the environment variables for this PowerShell session. `r`n$(Resolve-Error)" 
            If (-not $ContinueOnError) {
                Throw "Failed to refresh the environment variables for this PowerShell session: $($_.Exception.Message)"
            }
        }
    }

}

#===============================================================================
# Helpers
#===============================================================================


function Read-File {
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, Position=0)]
        [Alias('p', 'file', 'f')]
        [String]$Path
    )
    try{
        $StrData = Get-Content -Path $Path -Raw
        return $StrData
    } 
    catch [Exception] { 
        Write-Host -ForegroundColor DarkRed "[ERROR]" $_.Exception.Message.Trim()
    }

    
}

function Get-WindowsPowershellPath{
    try {
        $script:MyDocumentsFolderPath = [Environment]::GetFolderPath("MyDocuments")
    }
    catch {
        $script:MyDocumentsFolderPath = $null
    }

    $WinPSPath = ''

    $script:MyDocumentsPSPath = if ($script:MyDocumentsFolderPath) {
        $WinPSPath = Join-Path -Path $script:MyDocumentsFolderPath -ChildPath "WindowsPowerShell"
    }
    else {
        $WinPSPath = 'c:\' 
        $WinPSPath += Join-Path -Path $env:USERPROFILE -ChildPath "Documents\WindowsPowerShell"
    }
    return $WinPSPath
}


function Reload-Profile {
    $Path = (Get-Item $Profile).DirectoryName
    $aliases=(Get-AliasList $Path).Name
    foreach($a in $aliases){
         Remove-Alias $a -Force -ErrorAction ignore
    }
    . "$Profile"
}

Function Get-MissionImpossible {
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(932, 150)
    Start-Sleep -m 150
    [console]::beep(1047, 150)
    Start-Sleep -m 150
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(699, 150)
    Start-Sleep -m 150
    [console]::beep(740, 150)
    Start-Sleep -m 150
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(932, 150)
    Start-Sleep -m 150
    [console]::beep(1047, 150)
    Start-Sleep -m 150
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(784, 150)
    Start-Sleep -m 300
    [console]::beep(699, 150)
    Start-Sleep -m 150
    [console]::beep(740, 150)
    Start-Sleep -m 150
    [console]::beep(932, 150)
    [console]::beep(784, 150)
    [console]::beep(587, 1200)
    Start-Sleep -m 75
    [console]::beep(932, 150)
    [console]::beep(784, 150)
    [console]::beep(554, 1200)
    Start-Sleep -m 75
    [console]::beep(932, 150)
    [console]::beep(784, 150)
    [console]::beep(523, 1200)
    Start-Sleep -m 150
    [console]::beep(466, 150)
    [console]::beep(523, 150)
}

Function Sync-Profile{
    $PwshCoreProfile = $Profile
    $WindPwshProfile = Get-Variable -Name WindowsPwshProfile -ValueOnly -Scope Global -ErrorAction Ignore
    if($WindPwshProfile -eq $null){
        $WindPwshProfile = 'c:\DOCUMENTS\WindowsPowerShell\Microsoft.PowerShell_profile.ps1'
        Set-Variable -Name WindowsPwshProfile -Value $WindPwshProfile -Scope Global -option allscope, readonly -ErrorAction Ignore
    }

    $PwshCoreProfileLastUpdate = (Get-Item $PwshCoreProfile).LastWriteTime
    $WindPwshProfileLastUpdate = (Get-Item $WindPwshProfile).LastWriteTime  
    $Profiles = @{}
    $LatestDate = $null
    $LatestFile = ''
    $OlderFile = ''
    $Profiles.add( $PwshCoreProfileLastUpdate, $PwshCoreProfile )
    $Profiles.add( $WindPwshProfileLastUpdate, $WindPwshProfile )
    $Profiles.keys | ForEach-Object{
        if (($_ -ne $null) -and (($LatestDate -eq $null) -or ($_ -gt $LatestDate))) {
            $LatestDate = $_ 
            $LatestFile = $Profiles[$_]
        }
    } 
    Write-Host "===============================================================================" -f DarkRed
    Write-Host "POWERSHELL PROFILE SYNCHRONIZATION" -f DarkYellow;
    Write-Host "===============================================================================" -f DarkRed  
    Write-Host ("Most Recent`t") -nonewline -foregroundcolor DarkYellow

    if($LatestFile -eq $PwshCoreProfile){
        $Diff = $LatestDate - $WindPwshProfileLastUpdate
        Write-Host ("ᶜᵒʳᵉ⁷`t`t+ $Diff") -foregroundcolor DarkCyan 
        Write-Host ("copying ᶜᵒʳᵉ⁷ => ˡᵉᵍᵃᶜʸ⁵") -foregroundcolor DarkCyan 
        $OlderFile = $WindPwshProfile
        
    }else{
        $Diff = $LatestDate - $PwshCoreProfileLastUpdate
        Write-Host ("ˡᵉᵍᵃᶜʸ⁵`t`t+ $Diff") -foregroundcolor DarkCyan
        Write-Host ("copying ˡᵉᵍᵃᶜʸ⁵ => ᶜᵒʳᵉ⁷ ") -foregroundcolor DarkCyan 
        $OlderFile = $PwshCoreProfile
    }

    $OlderFileBAK = $OlderFile + '.BAK'
    Copy-Item $OlderFile $OlderFileBAK
    Copy-Item $LatestFile $OlderFile

    Write-Host "[$OlderFile] backup==> $OlderFileBAK" -f Darkgray;
    Write-Host "[$LatestFile] copy==> $OlderFile" -f Darkgray;
}

Function Save-TerminalSettings{
   
    pushd "P:\SystemConfiguration\Microsoft-Terminal"
    $SettingsFile = 'C:\Users\radic\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json'
    [string]$DateString = (Get-Date).GetDateTimeFormats()[8]
    [string]$Content = 'Windows Terminal Profile BACKUP'
    [string]$Content += "`n`nBACKUP ON`t$DateString`nFILE     `t$SettingsFile"
    $CurrentBackup = "P:\SystemConfiguration\Microsoft-Terminal\current_settings\settings.json"
    $ReadMe = "P:\SystemConfiguration\Microsoft-Terminal\current_settings\README.md"
    New-Item -Path $ReadMe -ItemType File -Force -EA Ignore | Out-Null
    Remove-Item -Path $ReadMe -Force | Out-Null    
    Set-Content -Path $ReadMe -Value $Content
    if(-not(Test-Path $CurrentBackup)){
        New-Item -Path $CurrentBackup -ItemType File -Force -EA Ignore | Out-Null
        Remove-Item -Path $CurrentBackup -Force | Out-Null
        Copy-Item $SettingsFile $CurrentBackup
        Write-Host "[TERMINAL]`t" -f DarkGreen -NoNewLine
        Write-Host "$SettingsFile ==> $CurrentBackup" -f DarkGray
    }
    else{
        $base = (Get-Item -Path $CurrentBackup).Basename
        $dir = (Get-Item -Path $CurrentBackup).DirectoryName
        [string]$epoch = Get-UnixTime
        $name = $base + '_' + $epoch + '.json'
        $NewBackup = Join-Path $dir $name
        Copy-Item $CurrentBackup $NewBackup
        Copy-Item $SettingsFile $CurrentBackup
        Write-Host "[TERMINAL]`t" -f DarkGreen -NoNewLine
        Write-Host "$CurrentBackup ==> $NewBackup" -f DarkGray        
        Write-Host "[TERMINAL]`t" -f DarkGreen -NoNewLine
        Write-Host "$SettingsFile ==> $CurrentBackup" -f DarkGray
    }


}


function GitExecutable{
    [CmdletBinding(SupportsShouldProcess)]
    param ()
    $GitPath = (get-command "git.exe" -ErrorAction Ignore).Source
     
     if(( $GitPath -ne $null ) -And (Test-Path -Path $GitPath)){
        return $GitPath
     }
     $GitPath = (Get-ItemProperty -Path "HKLM:\SOFTWARE\GitForWindows" -Name 'InstallPath' -ErrorAction Ignore).InstallPath
     if( $GitPath -ne $null ) { $GitPath = $GitPath + '\bin\git.exe' }
     if(Test-Path -Path $GitPath){
        return $GitPath
     }
     $GitPath = (Get-ItemProperty -Path "$ENV:OrganizationHKCU\Git" -Name 'InstallPath' -ErrorAction Ignore).InstallPath
     if( $GitPath -ne $null ) { $GitPath = $GitPath + '\bin\git.exe' }
     if(( $GitPath -ne $null ) -And (Test-Path -Path $GitPath)){
        return $GitPath
     }
}

Function Save-Profile{
    $Path = (Get-Item -Path $Profile).DirectoryName

    Write-ChannelMessage "Go in $Path\Profile"
    pushd "$Path\Profile"
	
    $pname = (Get-Item "$Profile").Name
    $ppath = (Get-Item "$Profile").Fullname
    Write-ChannelMessage "Copy-Item $Profile to $pname"
    Copy-Item "$Profile" "$pname"

	ForEach($f in (gci . -file -recurse -filter '*.ps1').Fullname){
		Write-ChannelMessage "SCRIPT: $f"
	}
	
	
    $GitExe = GitExecutable
	$Msg = 'Latest Profile, commited on ' + (Get-Date).GetDateTimeFormats()[6]
	Write-ChannelMessage "GIT PUSH...."
    &"$GitExe" commit -a -m "$Msg"
    &"$GitExe" push
    popd
}



Function Update-NetInfo{
    $Data=(iwr 'http://ipinfo.io/json')
    if($Data.StatusCode -eq 200){ 
        Remove-Variable 'NETInfoTable' -ErrorAction ignore -Force
        $NETInfoTable = ($Data.Content | ConvertFrom-Json -AsHashtable)
        $NETInfoTable
        New-Variable -Name 'NETInfoTable' -Scope Global -Option ReadOnly,AllScope -Value $NETInfoTable
    }
}



Function Get-ApplicationPath([string]$Executable){
    $Command=(get-command $Executable)
    if($Command -ne $null){ return $Command.Path }
    return $null
}


function Get-ModulesPath([int]$Index=0, [switch]$Verbose){
     $VarModPath=$env:PSModulePath
     if($Verbose){
        $VarModPathArray=$env:PSModulePath.split(';')
        [int]$i = 0
        ForEach($p in $VarModPathArray){
            Write-Host "$i => $p"
            $i++
        }
     }
     $Index=$VarModPath.IndexOf(';')
      if($Index -ne -1) { $ModulesPath=$VarModPath.Substring(0,$Index) ; return $ModulesPath }
      else{ $ModulesPath=$VarModPath ; return $ModulesPath }
}

function Invoke-IsAdministrator  {  
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}

function Get-FolderHash{
        param(
        [parameter(mandatory=$true)]
        [String]
        $Path
        )
        Get-FileHash -InputStream ([IO.MemoryStream]::new([char[]]"$(Get-ChildItem -Path $Path -Recurse|Out-String)"))
}

Function Set-EnvironmentVariable{
        param(
        [parameter(mandatory=$true)]
        [String]$Name,
        [parameter(mandatory=$true)]
        [String]$Value,
        [parameter(mandatory=$true)]
        [ValidateSet('User', 'Machine', 'Session')]
        [String]$Scope
        )
    switch($Scope)
    {
        'Session' { 
            $CurrentSetting=( Get-ChildItem -Path env: -Recurse | % -process { if($_.Name -eq $Name) {$_.Value} })
         
            if(($CurrentSetting -eq $null) -Or ($CurrentSetting -ne $null -And $CurrentSetting.Value -ne $Value)){
                Write-Host "Environment Setting $Name is not set or has a different value, changing to $Value"
                $TempPSDrive = $(get-date -Format "temp\hhh-\mmmm-\sss")
                new-psdrive -name $TempPSDrive -PsProvider Environment -Root env:| Out-null
                $NewValPath=( "$TempPSDrive" + ":\$Name")
                New-Item -Path $NewValPath -Value $Value| Out-null
                Remove-PSDrive $TempPSDrive -Force | Out-null
            }
      }
        'User' { 
            Write-Host "Setting $Name --> $Value [User]"  -ForegroundColor Yellow
            [System.Environment]::SetEnvironmentVariable($Name,$Value,[System.EnvironmentVariableTarget]::User)
          }
        'Machine' { 
            Write-Host "Setting $Name --> $Value [Machine]"  -ForegroundColor Yellow
            [System.Environment]::SetEnvironmentVariable($Name,$Value,[System.EnvironmentVariableTarget]::Machine)
        }
    
    }
}

function Show-PromptNoPath{
    $currentpath=(Get-Location).Path
    $IsAdmin=Invoke-IsAdministrator 
    if($PSVersionTable.PSVersion.Major -eq 5){
        Write-Host ("ˡᵉᵍᵃᶜʸ⁵") -nonewline -foregroundcolor DarkCyan
        if($IsAdmin){write-host "ᵃᵈᵐⁱⁿ" -f Darkred -nonewline}
    }else {
        Write-Host ("ᶜᵒʳᵉ⁷") -nonewline -foregroundcolor DarkCyan
        #Write-Host ("cͨoͦrͬeͤ7") -nonewline -foregroundcolor DarkCyan
        if($IsAdmin){write-host "ᵃᵈᵐⁱⁿ" -f Darkred -nonewline}
    }
    
    Write-Host (" >") -nonewline -foregroundcolor DarkGray
    return " "
}

function Show-Prompt{
    $currentpath=(Get-Location).Path
    $IsAdmin=Invoke-IsAdministrator 
    if($PSVersionTable.PSVersion.Major -eq 5){
        Write-Host ("ˡᵉᵍᵃᶜʸ⁵") -nonewline -foregroundcolor DarkCyan
        if($IsAdmin){write-host "ᵃᵈᵐⁱⁿ" -f Darkred -nonewline}
    }else {
			
        
        
        if($IsAdmin){
			Write-Host ("ᶜᵒʳᵉ⁷") -nonewline -foregroundcolor DarkYellow
			write-host " < ᵃᵈᵐⁱⁿ > " -f Darkred -nonewline
		}else{
			Write-Host ("ᶜᵒʳᵉ⁷") -nonewline -foregroundcolor DarkCyan
		}
    }
    
    Write-Host ("$currentpath>") -nonewline -foregroundcolor DarkGray
    return " "
}


function Set-SmallPrompt{
    [CmdletBinding(SupportsShouldProcess)]
    param()
    try{
        Write-Host "New-Alias 'prompt' Show-PromptNoPath -force -Scope Global -option allscope" -f Darkred
        New-Alias 'prompt' Show-PromptNoPath -force -Scope Global -option allscope
    }catch{
        write-Warning -Message "$_"
    }  
}
function Reset-Prompt{
    [CmdletBinding(SupportsShouldProcess)]
    param()
    try{
        Write-Host "New-Alias 'prompt' Show-Prompt -force -Scope Global -option allscope" -f Darkred
        New-Alias 'prompt' Show-Prompt -force -Scope Global -option allscope
    }catch{
        write-Warning -Message "$_"
    }  
}

function Show-ExtendedInfo
{

    Write-Host "                 𝙐𝙎𝙀𝙁𝙐𝙇 𝙀𝙉𝙑𝙄𝙍𝙊𝙉𝙈𝙀𝙉𝙏 𝙑𝘼𝙍𝙄𝘼𝘽𝙇𝙀𝙎              " -Foreground DarkCyan

    Write-Host "𝙎𝙮𝙨𝙩𝙚𝙢𝙎𝙘𝙧𝙞𝙥𝙩𝙨𝙋𝙖𝙩𝙝`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:SystemScriptsPath" -ForegroundColor DarkRed

    Write-Host "𝙎𝙘𝙧𝙚𝙚𝙣𝙨𝙝𝙤𝙩𝙁𝙤𝙡𝙙𝙚𝙧`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:ScreenshotFolder" -ForegroundColor DarkRed

    Write-Host "𝘿𝙚𝙫𝙚𝙡𝙤𝙥𝙢𝙚𝙣𝙩𝙍𝙤𝙤𝙩`t`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:DevelopmentRoot" -ForegroundColor DarkRed

    Write-Host "𝙎𝙘𝙧𝙞𝙥𝙩𝙨𝙍𝙤𝙤𝙩`t`t`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:ScriptsRoot" -ForegroundColor DarkRed

    Write-Host "𝙋𝙎𝙎𝙘𝙧𝙞𝙥𝙩𝙨𝘿𝙚𝙫`t`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:PowerShellScriptsDev" -ForegroundColor DarkRed

    Write-Host "𝙬𝙬𝙬𝙧𝙤𝙤𝙩`t`t`t`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:wwwroot" -ForegroundColor DarkRed

    Write-Host "𝙎𝙮𝙨𝙩𝙚𝙢𝙎𝙘𝙧𝙞𝙥𝙩𝙨𝙋𝙖𝙩𝙝`t==>`t" -NoNewLine -ForegroundColor Magenta
    Write-Host "$env:SystemScriptsPath" -ForegroundColor DarkRed
    Write-Host ">> 𝘥𝘦𝘷, 𝘤𝘰𝘥𝘦, 𝘱𝘴𝘥𝘦𝘷 = 𝘨𝘰 𝘪𝘯 𝘥𝘦𝘷 𝘥𝘪𝘳" -Foreground DarkBlue
}
function Show-SystemInfo
{
    ProfileInfo
    ExtendedInfo
}

function Show-Header
{
    cls
    Write-Host "`n`n"
    Write-Host "                                         𝒜𝓇𝓈 𝒮𝒸𝓇𝒾𝓅𝓉𝓊𝓂: 𝒯𝒽ℯ 𝒜𝓇𝓉 ℴ𝒻 𝒞ℴ𝒹ℯ" -f DarkRed
    Write-Host "                                       𝘸𝘪𝘯𝘥𝘰𝘸𝘴 𝘵𝘦𝘳𝘮𝘪𝘯𝘢𝘭 - 𝘱𝘰𝘸𝘦𝘳𝘴𝘩𝘦𝘭𝘭 - 𝘥𝘰𝘴 - 𝘷𝘴" -f DarkRed
    Write-Host "`n`n"
    #Write-Host "𝑡𝑦𝑝𝑒 ＇𝑠𝑦𝑠𝑖𝑛𝑓𝑜＇ 𝑓𝑜𝑟 𝑠𝑦𝑠𝑡𝑒𝑚 𝑑𝑒𝑡𝑎𝑖𝑙𝑠" -f DarkRed
    #Write-Host "𝑡𝑦𝑝𝑒 ❜𝒄𝒎𝒅𝒍𝒊𝒔𝒕❜ 𝑓𝑜𝑟 𝒂 𝒍𝒊𝒔𝒕 𝒐𝒇 𝒑𝒐𝒔𝒔𝒊𝒃𝒍𝒆 𝒄𝒐𝒎𝒎𝒂𝒏𝒅𝒔" -f DarkRed
    #Write-Host '𝑡𝑦𝑝𝑒 "$Global:NETInfoTable" 𝑓𝑜𝑟 network information' -f DarkRed
    #Write-Host "`n`n"                                                                                   
}


function Import-AllDevelopmentModules{
    try{
        $m = 'C:\DOCUMENTS\PowerShell\Module-Development'
        pushd $m
        $Modules = (gci . -Directory -Filter 'PowerShell.Module.*').Name
        ForEach($mod in $Modules){

            Write-Host "[IMPORT] " -f DarkRed -NoNewLine
            Write-Host " import modules $mod..............`t`t" -f DarkGray -NoNewLine
            $null = Import-Module $mod -DisableNameChecking -Scope Global -Force -ErrorAction Ignore
            Write-Host "[OK]" -f DarkGreen
        }
		
    }catch [Exception]{
        $Msg="LOADER Error: $($PSItem.ToString())"
        Write-Error $Msg
    }finally{
		popd
	}
}


#===============================================================================
# Dependencies
#===============================================================================

function Invoke-LoadProfileDependencies{
    $Script:ProfileDependencies = @( Get-ChildItem -Path $Script:ProfileIncPath -Filter '*.ps1' )
    $Script:DependencyCount = $Script:ProfileDependencies.Count

    #Dot source the files
    Foreach ($file in $Script:ProfileDependencies) {
        Try {
            $Depname = (Get-Item -Path $file).Name

            . "$file"
            #Write-Host -f Green "[OK] " -NoNewline
            #Write-Host " + $Depname imported" -f DarkGray
        }  
        Catch {
            $Global:ProfileErrors++
            Write-Warning -Message "Failed to import file $file $_"
        }
    }
}

<#
Setenv -Name 'PSModComp' -Value 'c:\DOCUMENTS\PowerShell\Module-Development\PowerShell.Module.Compiler' -Scope 'Machine'
Setenv -Name 'ScriptsRoot' -Value 'P:\Scripts' -Scope 'Machine'
Setenv -Name 'PowerShellScriptsDev' -Value 'P:\Scripts' -Scope 'Machine'
Setenv -Name 'Sandbox' -Value 'P:\Scripts\PowerShell.Sandbox' -Scope 'Machine'
Setenv -Name 'moddev' -Value 'c:\DOCUMENTS\PowerShell\Module-Development' -Scope 'User'
#>

function goto{
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, HelpMessage="Location, help for list")]
        [ValidateNotNullOrEmpty()]
        [String]$Location
    )


    $options = @('profile','tmp', 'mydocument', 'code', 'dev', 'home', 'psdev', 'scripts', 'tools', 'sandbox', 'wwwroot', 'PSModCore', 'PSModComp', 'moddev', 'Github', 'Builder', 'modpath')
    Switch ($Location) {
        profile         { goto-profile ;    Break ; }
        tmp             { goto-tmp ;    Break ; }
        mydocument      { goto-mydocument ;     Break ; }
        code            { goto-code ;   Break ; }
        dev             { goto-dev ;    Break ; }
        home            { goto-home ;   Break ; }
        psdev           { goto-psdev ;  Break ; }
        scripts         { goto-scripts ;        Break ; }
        tools           { goto-tools ;  Break ; }
        sandbox         { goto-sandbox ;        Break ; }
        wwwroot         { goto-wwwroot ;        Break ; }
        PSModCore       { goto-PSModCore ;      Break ; }
        PSModComp       { goto-PSModComp ;      Break ; }
        moddev          { goto-moddev ; Break ; }
        Github          { goto-PSModGithu ;     Break ; }
        Builder         { goto-PSModuleBu ;     Break ; }
        modpath         { goto-modpath ;        Break ; }
        help{

            $msg = '
Type goto <location>
where location is one of the following:
'
            write-host "$msg" -f Cyan
            ForEach($l in $options){
                Write-Host "> $l" -f DarkCyan
            }
            
            
            Break
        }
    }
}

function goto-profile       {  $p = (Get-Item $Profile).DirectoryName ;Write-Host "Pushd => $p" -f Red ; Push-Location $p; }
function goto-tmp           {  Push-Location ( (New-TemporaryDirectory).Fullname ) ; }
function goto-mydocuments   {  $mydocuments = [environment]::getfolderpath("mydocuments") ; Write-Host "Pushd => $mydocuments" ; Push-Location $mydocuments; }
function goto-code          {  Write-Host "Pushd => $env:DevelopmentRoot" ; Push-Location $env:DevelopmentRoot; }
function goto-dev           {  Write-Host "Pushd => $env:DevelopmentRoot" ; Push-Location $env:DevelopmentRoot; }
function goto-home          {  Write-Host "Pushd => $env:DevelopmentRoot" ; Push-Location ~; }
function goto-psdev         {  Write-Host "Pushd => $env:PowerShellScriptsDev" ; Push-Location $env:PowerShellScriptsDev; }
function goto-scripts       {  Write-Host "Pushd => $env:ScriptsRoot" ; Push-Location $env:ScriptsRoot; }
function goto-tools         {  Write-Host "Pushd => $env:ToolsRoot" ; Push-Location $env:ToolsRoot; }
function goto-sandbox       {  Write-Host "Pushd => $env:Sandbox" ; Push-Location $env:Sandbox; }
function goto-wwwroot       {  Write-Host "Pushd => $env:wwwroot" ; Push-location $env:wwwroot; }
function goto-PSModCore     {  Write-Host "Pushd => $env:PSModCore" ; Push-location $env:PSModCore; }
function goto-PSModComp     {  Write-Host "Pushd => $env:PSModComp" ; Push-location $env:PSModComp; }
function goto-syscfg        {  $scp = "$env:ScriptsRoot\SystemConfiguration\SysConfig"; Write-Host -f Blue "Pushd => $scp" ; Push-Location $scp; }
function goto-moddev     {  Write-Host "Pushd => $env:moddev" ; Push-location $env:moddev; }
function goto-PSModGithub     {  Write-Host "Pushd => $env:PSModGithub" ; Push-location $env:PSModGithub; }
function goto-PSModuleBuilder     {  Write-Host "Pushd => $env:PSModuleBuilder" ; Push-location $env:PSModuleBuilder; }
function goto-modpath       {  $p=Get-UserModulesPath; Set-location $p; }
function Invoke-Screenshot      { start-process "${Env:ToolsRoot}\screenshot.exe" -WindowStyle hidden ; }
function Invoke-Sublime         { &"${Env:ProgramFiles}\Sublime Text 3\sublime_text.exe" $args }
function Invoke-Notepad         { &"C:\Programs\Shims\npad.exe" $args }
function Invoke-Baretail        { $bt=(get-command baretail).Source;&"$bt" $args }
function Invoke-Terminal0 { start-process "C:\Programs\Shims\terminal.exe" -ArgumentList "-w 0 nt" ; }
function Invoke-T0Split { start-process "C:\Programs\Shims\terminal.exe" -ArgumentList "-w 0 split-pane" ; }
function Invoke-Terminal { start-process "C:\Programs\Shims\terminal.exe" -ArgumentList "-w 1 nt" ; }
function Invoke-TerminalAdmin { start-process "C:\Programs\Shims\terminal.exe" -ArgumentList "-w 1 nt" -verb RunAs}

function Edit-Profile{ 
<#
.FORWARDHELPTARGETNAME Get-Help
.FORWARDHELPCATEGORY Cmdlet
#>
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $false)]
        [Alias('a')]
        [switch]$All

    )       
    Write-Host "EDITING PROFILE ==> $Profile" -f Blue 
    Invoke-Notepad $Profile
    if($All -eq $False) { return }
    $Directory=(Get-Item -Path $Profile).DirectoryName
    $Directory=Join-Path $Directory 'inc'
    $Dependencies = (gci $Directory -File -Filter '*.ps1').FullName
    ForEach($Dep in $Dependencies){
        Write-Host "EDITING DEPEMDENCY ==> $Dep" -f Cyan 
        Invoke-Notepad $Dep
    }
}

function x {
    $xplorer='C:\Windows\explorer.exe'
    $localpath=(Get-Location).Path
    &$xplorer $localpath
}

function Script:Write-AliasMsg{ 
    # .ExternalHelp C:\MyScripts\Update-Month-Help.xml
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, position = 0)]
        [Alias('m')]
        [string]$Message,
        [Parameter(Mandatory = $false)]
        [Alias('q')]
        [switch]$Quiet,
        [Parameter(Mandatory = $false)]
        [ValidateSet('e', 's', 'n')]
        [Alias('t')]
        [string]$Type
    )
    [ConsoleColor]$TitleColor = 'Blue'
    [ConsoleColor]$MessageColor = 'DarkGray'    
    if (-not $PSBoundParameters.ContainsKey('Type')) { $Type = 'n' ; }
    if($Quiet){return}
    if($Type -eq 'e'){$TitleColor = 'DarkRed';$MessageColor = 'DarkYellow'}  
    if($Type -eq 's'){$TitleColor = 'Blue';$MessageColor = 'DarkGreen'}  
    if($Type -eq 'n'){$TitleColor = 'Blue';$MessageColor = 'DarkGray'}  
     
    Write-Host "[ALIAS] " -n -f $TitleColor
    Write-Host "$Message" -f $MessageColor
}

function New-PersistentProfileAlias{ 
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $true, position = 0)]
        [Alias('n')]
        [string]$Name,
        [Parameter(Mandatory = $true, position = 1)]
        [Alias('v')]
        [string]$Value,
        [Parameter(Mandatory = $true, position = 2)]
        [Alias('d')]
        [string]$Description,
        [Parameter(Mandatory = $false)]
        [Alias('q')]
        [switch]$Quiet

    )    
    $q = $Quiet
    if($Description -eq 'na'){$Description = 'not available'}
    try{
        New-Alias $Name -Value $Value -Description $Description -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
        #$dn=$a.DisplayName
        #Write-AliasMsg "$dn" -q:$q -t 's'
        
    }
    catch{
        Write-AliasMsg " error with $Name [$Value] $_" -q:$q -t 'e'
    }
    
}
