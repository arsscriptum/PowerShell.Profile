<#̷#̷\
#̷\ 
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\    
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#̷\
#̷\   Generated on ___BUILDDATE___ 
#̷\
#̷##>


function Set-Transcript
{
    $pindex = 0 ; (Get-Process).Name | % { $pname=$_;if($pname -like "pwsh") { $pindex = $pindex +1 ; } }
    $curdate = $(get-date -Format "yyyy.dd.MM-HH\hmm\m")
    $TranscriptDirectory = "C:\Tmp\TerminalTranscripts\Powershell"
    $Transcript = "$TranscriptDirectory\$curdate" + "-PID$PID" + '.log'
    $null=New-Item -Path $TranscriptDirectory -ItemType Directory -Force -ErrorAction ignore
    Start-Transcript -IncludeInvocationHeader -Path $Transcript -NoClobber
}