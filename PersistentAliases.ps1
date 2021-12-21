<#̷#̷\
#̷\
#̷\   ⼕龱ᗪ㠪⼕闩丂ㄒ龱尺 ᗪ㠪ᐯ㠪㇄龱尸爪㠪𝓝ㄒ
#̷\   🇵​​​​​🇴​​​​​🇼​​​​​🇪​​​​​🇷​​​​​🇸​​​​​🇭​​​​​🇪​​​​​🇱​​​​​🇱​​​​​ 🇸​​​​​🇨​​​​​🇷​​​​​🇮​​​​​🇵​​​​​🇹​​​​​ 🇧​​​​​🇾​​​​​ 🇨​​​​​🇴​​​​​🇩​​​​​🇪​​​​​🇨​​​​​🇦​​​​​🇸​​​​​🇹​​​​​🇴​​​​​🇷​​​​​@🇮​​​​​🇨​​​​​🇱​​​​​🇴​​​​​🇺​​​​​🇩​​​​​.🇨​​​​​🇴​​​​​🇲​​​​​
#̷\
#̷##>

#===============================================================================
# Helpers amnd Wrappers
#===============================================================================
. "$PSScriptRoot\PersistentFunctions.ps1"
New-Alias nppa -Value New-PersistentProfileAlias -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope

$RegistryPath = "$ENV:OrganizationHKCU\CodeCastor.PowerShell.ModuleBuilder"
$BuildScript = (Get-ItemProperty $RegistryPath -Name 'BuildScriptPath').BuildScriptPath
$BuildModuleScript = (Get-ItemProperty $RegistryPath -Name 'BuildModuleScript').BuildModuleScript

nppa make       "$BuildScript"                 'na'
nppa makeall    "$BuildModuleScript"           'na'

#===============================================================================
# ALIASES
#===============================================================================
nppa profile     Edit-Profile                   'na'
nppa prompt      Show-Prompt                    'na'
nppa tmp         goto-tmp                       'Create a temporary directory and go to this location to do some tests'
nppa whereis     Get-ApplicationPath            'Where is the Executable located? '
nppa Setenv      Set-EnvironmentVariable        'Set Environment Value !'
nppa modpath     goto-modpath                   'Get PS Modules Path !'
nppa sysinfo     SystemInfo                     'Get System Information !'
nppa cmdlist     Get-CommandsAndAliases         'Get Custom Module Command list!'
nppa tail        Invoke-Baretail                'na'
nppa subl        Invoke-Sublime                 'na'
nppa edit        Invoke-Sublime                 'na'
nppa termadm     Invoke-TerminalAdmin           'na'
nppa term        Invoke-Terminal                'na'
nppa ss          Invoke-Screenshot              'na'
nppa read        ReadFile                       'na'
nppa Getcmd      Get-command                    'na'
nppa Getmod      Get-module                     'na'
nppa home        goto-home                      'Set Location To $Home !'
nppa dev         goto-dev                       'Set Location To $env:DevelopmentRoot !'
nppa code        goto-code                      'Set Location To $env:DevelopmentRoot !'
nppa gs          goto-scripts                   'Set Location To $env:ScriptsRoot !'
nppa tools       goto-tools                     'Set Location To $env:ToolsRoot !'
nppa psdev       goto-psdev                     'Set Location To $env:PowerShellScriptsDev !'
nppa sbox        goto-sandbox                   'Set Location To $env:Sandbox !'
nppa www         goto-wwwroot                   'Set Location To $env:wwwroot !'

nppa mydocs      goto-mydocuments               'na'
nppa doc         goto-mydocuments               'na'

nppa pt          goto-PSModCore                 'Set Location To $env:PSModCore !'
nppa psmodcore   goto-PSModCore                 'Set Location To $env:PSModCore !'
nppa psmodgit    goto-PSModGithub               'Set Location To $env:PSModGithub !'
nppa pscore      goto-PSModCore                 'Set Location To $env:PSModCore !'
nppa psgit       goto-PSModGithub               'Set Location To $env:PSModGithub !'
nppa psmodbuild  goto-PSModuleBuilder           'Set Location To $env:PSModuleBuilder !'   
nppa psmb        goto-PSModuleBuilder           'Set Location To $env:PSModuleBuilder !'
