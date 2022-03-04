


function Get-PowershellVersionInfo {
    $VerStr=$PSVersionTable.PSVersion.ToString()
    $VerEdStr=$PSVersionTable.PSEdition.ToString()
    $VerNum = $PSVersionTable.PSVersion.Major
    
    if($VerNum -eq 5){
        #Write-Host "`nｗｉｎｄｏｗｓ`t" -f Cyan -NoNewLine
        #Write-Host "ｐｏｗｅｒｓｈｅｌｌ`n`n" -f DarkCyan -NoNewLine
        Write-Host "powershell> " -f DarkCyan
    }else{
        #Write-Host "`nｐｏｗｅｒｓｈｅｌｌ`t" -f DarkCyan -NoNewLine
        #Write-Host  "CͨOͦRͬEͤ`n`n" -f Cyan -NoNewLine
        Write-Host "powershell> " -f DarkCyan
    }
}
