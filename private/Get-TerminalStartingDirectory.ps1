<#̷#̷\
#̷\ 
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\    
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#̷\
#̷\   Generated on ___BUILDDATE___ 
#̷\
#̷##>


function Get-TerminalStartingDirectory{ 
    [CmdletBinding(SupportsShouldProcess)]
    Param
    (
        [Parameter(Mandatory = $false)]
        [Alias('s', 'set')]
        [switch]$SetLocation
    )    
    $RegPath = "$ENV:OrganizationHKCU\windows.terminal"
    $RegKeyName = 'StartingDirectory'
    $RegKey = (Get-ItemProperty -Path $RegPath -Name $RegKeyName -ErrorAction ignore)

    if($RegKey -ne $null){
        $StartingDirectory = $RegKey.StartingDirectory
    }else {
        $StartingDirectory = $Home
    }
    if($SetLocation) { Set-Location $StartingDirectory; }
    return $StartingDirectory
}
