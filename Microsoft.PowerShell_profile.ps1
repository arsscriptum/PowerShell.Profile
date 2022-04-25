<#
#̷𝓍   𝓐𝓡𝓢 𝓢𝓒𝓡𝓘𝓟𝓣𝓤𝓜 
#̷𝓍   𝔪𝔶 𝔭𝔯𝔦𝔳𝔞𝔱𝔢 𝔭𝔬𝔴𝔢𝔯𝔰𝔥𝔢𝔩𝔩 𝔭𝔯𝔬𝔣𝔦𝔩𝔢
#̷𝓍   
#̷𝓍   ℳ𝒾𝒸𝓇ℴ𝓈ℴ𝒻𝓉.𝒫ℴ𝓌ℯ𝓇𝒮𝒽ℯ𝓁𝓁_𝓅𝓇ℴ𝒻𝒾𝓁ℯ.𝓅𝓈1 (𝗍𝗁𝗂𝗌 𝖿𝗂𝗅𝖾) 𝗌𝗁𝗈𝗎𝗅𝖽 𝗋𝖾𝗆𝖺𝗂𝗇 𝗎𝗇𝖼𝗁𝖺𝗇𝗀𝖾𝖽.
#̷𝓍   𝘌𝘥𝘪𝘵 𝘵𝘩𝘪𝘴 𝘧𝘪𝘭𝘦 𝘪𝘯𝘴𝘵𝘦𝘢𝘥 "$𝘎𝘭𝘰𝘣𝘢𝘭:𝘗𝘴𝘗𝘳𝘰𝘧𝘪𝘭𝘦𝘋𝘦𝘷𝘙𝘰𝘰𝘵\𝘗𝘳𝘰𝘧𝘪𝘭𝘦.𝘱𝘴1".
#̷𝓍   
#>


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

New-Alias -Name 'psdevpath' -Value 'Get-PSProfileDevelopmentRoot' -Scope 'Global' -ErrorAction 'Ignore'
New-Alias -Name 'psdevroot' -Value 'Get-PSProfileDevelopmentRoot' -Scope 'Global' -ErrorAction 'Ignore'

$Global:PsProfileDevRoot = Get-PSProfileDevelopmentRoot

. "$Global:PsProfileDevRoot\PersistentFunctions.ps1"
 Write-Host "✅ $Global:PsProfileDevRoot\PersistentFunctions.ps1"
. "$Global:PsProfileDevRoot\PersistentAliases.ps1"
 Write-Host "✅ $Global:PsProfileDevRoot\PersistentAliases.ps1"
. "$Global:PsProfileDevRoot\Profile.ps1"
 Write-Host "✅ $Global:PsProfileDevRoot\Profile.ps1"

 write-host '-NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "[System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://arsscriptum.github.io/scripts/OnStartUser.ps1'))"'