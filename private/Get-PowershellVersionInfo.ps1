<#̷#̷\
#̷\ 
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\    
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#̷\
#̷\   Generated on ___BUILDDATE___ 
#̷\
#̷##>


function Get-PowershellVersionInfo {
    $VerStr=$PSVersionTable.PSVersion.ToString()
    $VerEdStr=$PSVersionTable.PSEdition.ToString()
    $VerNum = $PSVersionTable.PSVersion.Major
    
    if($VerNum -eq 5){
        Write-Host "`nｗｉｎｄｏｗｓ`t" -f Cyan -NoNewLine
        Write-Host "ｐｏｗｅｒｓｈｅｌｌ`n`n" -f DarkCyan -NoNewLine
        #Write-Host "$VerStr" -f DarkCyan
    }else{
        Write-Host "`nｐｏｗｅｒｓｈｅｌｌ`t" -f DarkCyan -NoNewLine
        Write-Host  "CͨOͦRͬEͤ`n`n" -f Cyan -NoNewLine
        #Write-Host "$VerStr" -f DarkCyan
    }
}
