<#̷#̷\
#̷\ 
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\    
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#̷\
#̷\   Generated on ___BUILDDATE___ 
#̷\
#̷##>


function Kill-ResHoggers{
    Write-Host "`n`t`tKill Resource Hogger`n`t`t-----------------------" -f DarkCyan
    [string]$Killer=(get-command pskill).Source

    if($global:phoggers -eq $null){
        $global:phoggers = @('HxOutlook','Cloudflare WARP','RtkNGUI64','SearchIndexer','SearchApp','SearchProtocolHost','GameBar','GameBarFTServer','BuildNotificationApp','YourPhone','igfxHK','igfxTray','YourPhone','HPHotkeyNotification','CodeMeter','CmWebAdmin','CodeMeterCC','BraveUpdate')
    }

    $Processes = $global:phoggers
    ForEach($p in $Processes){
        $plen=$p.length
        
        Write-Host "Killing  $p" -f Cyan -NoNewLine
        $Res=&$Killer $p
        if($plen -gt 15){
            Write-Host "`t`t[ᴏᴋ]" -f Green
        }elseif($plen -gt 8){
            Write-Host "`t`t`t[ᴏᴋ]" -f Green
        }else{
            Write-Host "`t`t`t`t[ᴏᴋ]" -f Green
        }
    }
    Write-Host "`nDone. $Global:phoggers.Add`n" -f DarkYellow

}

function  Kill-ResHoggersAdmin{
    $credz = Get-AppCredentials Admin
    $Script = '[string]$Killer=(get-command pskill).Source

    if($global:phoggers -eq $null){
        $global:phoggers = @("HxOutlook","Cloudflare WARP","RtkNGUI64","SearchIndexer","SearchApp","SearchProtocolHost","GameBar","GameBarFTServer","BuildNotificationApp","YourPhone","igfxHK","igfxTray","YourPhone","HPHotkeyNotification","CodeMeter","CmWebAdmin","CodeMeterCC","BraveUpdate")
    }
    $i = 0
    $ArgumentsPs = ""
    $Processes = $global:phoggers
    $Processes.ForEach( { $p = $_ ; if($i -gt 0){ $ArgumentsPs += " , "} ; $ArgumentsPs += "$p" ; $i++ ; } )
    <#
    ForEach($p in $Processes){
        $plen=$p.length
        Write-Host "Killing  $p" -f Cyan -NoNewLine
        $Res=&$Killer $p
        if($plen -gt 15){
            Write-Host "`t`t[ᴏᴋ]" -f Green
        }elseif($plen -gt 8){
            Write-Host "`t`t`t[ᴏᴋ]" -f Green
        }else{
            Write-Host "`t`t`t`t[ᴏᴋ]" -f Green
        }
    }
    #>

    Write-Host "Killing  $ArgumentsPs" -f Cyan -NoNewLine
    Start-Process -FilePath $Killer -ArgumentList $ArgumentsPs -NoNewWindow
    Sleep 5
'
    $ScriptBlock = [ScriptBlock]::Create($Script)
    Invoke-Command -ScriptBlock $ScriptBlock -Credential $credz -ComputerName .
}