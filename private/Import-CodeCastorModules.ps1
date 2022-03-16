<#̷#̷\
#̷\ 
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\    
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#̷\
#̷\   Generated on ___BUILDDATE___ 
#̷\
#̷##>


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
