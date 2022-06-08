<#
  ╓──────────────────────────────────────────────────────────────────────────────────────
  ║   PowerShell Profile
  ╙──────────────────────────────────────────────────────────────────────────────────────
 #>

#===============================================================================
# Helpers amnd Wrappers
#===============================================================================
. "$PSScriptRoot\PersistentFunctions.ps1"
New-Alias nppa -Value New-PersistentProfileAlias -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope

$RegistryPath = "$ENV:OrganizationHKCU\PowerShell.ModuleBuilder"
$BuildScript = (Get-ItemProperty $RegistryPath -Name 'BuildScriptPath').BuildScriptPath
$BuildModuleScript = (Get-ItemProperty $RegistryPath -Name 'BuildModuleScript').BuildModuleScript

nppa make       "$BuildScript"                 'na'
nppa makeall    "$BuildModuleScript"           'na'
nppa 'Write-ChannelMessage' 'Log' 'na'
#===============================================================================
# ALIASES
#===============================================================================
nppa mod         Get-Module                     'na'
nppa modinfo     ModuleInfo                     'na'
nppa profile     Edit-Profile                   'na'
nppa prompt      Show-Prompt                    'na'
#nppa prompt      Show-PromptNoPath              'na'
nppa tmp         goto-tmp                       'Create a temporary directory and go to this location to do some tests'
nppa whereis     Get-ApplicationPath            'Where is the Executable located? '
nppa Setenv      Set-EnvironmentVariable        'Set Environment Value !'
nppa modpath     goto-modpath                   'Get PS Modules Path !'
nppa sysinfo     SystemInfo                     'Get System Information !'
nppa cmdlist     Get-CommandsAndAliases         'Get Custom Module Command list!'
nppa tail        Invoke-Baretail                'na'
nppa subl        Invoke-Sublime                 'na'
nppa edit        Invoke-Subl                    'na'
nppa termadm     Invoke-TerminalAdmin           'na'
nppa term        Invoke-Terminal                'na'
nppa ss          Invoke-Screenshot              'na'
nppa read        ReadFile                       'na'
nppa Getcmd      Get-command                    'na'
nppa Getmod      Get-module                     'na'
nppa home        goto-home                      'Set Location To $Home !'
nppa hdev        goto-HDev                      'Set Location To $env:HDev !'
nppa dev         goto-dev                       'Set Location To $env:DevelopmentRoot !'
nppa devwork     goto-devwork                   'Set Location To $env:DevelopmentRoot !'
nppa code        goto-code                      'Set Location To $env:DevelopmentRoot !'
nppa gs          goto-scripts                   'Set Location To $env:ScriptsRoot !'
nppa tools       goto-tools                     'Set Location To $env:ToolsRoot !'
nppa psdev       goto-psdev                     'Set Location To $env:PowerShellScriptsDev !'
nppa sbox        goto-sandbox                   'Set Location To $env:Sandbox !'
nppa www         goto-wwwroot                   'Set Location To $env:wwwroot !'
nppa syscfg      goto-syscfg                    'na'
nppa moddev      goto-moddev                    'na'
nppa mydocs      goto-mydocuments               'na'
nppa doc         goto-mydocuments               'na'
nppa gmod        Set-LocationToModule           'Set Location To specified module name !'
nppa modnet    goto-PSModNet                    'Set Location To $env:PSModNet !'
nppa modcore   goto-PSModCore                   'Set Location To $env:PSModCore !'
nppa modgit    goto-PSModGithub                 'Set Location To $env:PSModGithub !'
nppa modcm      goto-PSModCodeMeter             'Set Location To $env:PSModCodeMeter !'
nppa modconf       goto-PSModSysConf            'Set Location To $env:PSModSysConf !'
nppa modbuild  goto-PSModuleBuilder             'Set Location To $env:PSModuleBuilder !'   
nppa psmb        goto-PSModuleBuilder           'Set Location To $env:PSModuleBuilder !'
nppa programs    goto-programs                  'Set Location To $env:Programs !'
nppa prog        goto-programs                  'Set Location To $env:Programs !'
nppa videos      goto-myvideos                  'Set Location To $env:MyVideos !'
nppa vid         goto-myvideos                  'Set Location To $env:MyVideos !'

nppa d           Set-Location                   'na'

New-Alias ModAttackSuite -Value "Push-ModAttackSuite" -Description "Push-location $env:ModAttackSuite" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModCodeMeter -Value "Push-ModCodeMeter" -Description "Push-location $env:ModCodeMeter" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModCompiler -Value "Push-ModCompiler" -Description "Push-location $env:ModCompiler" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModCore -Value "Push-ModCore" -Description "Push-location $env:ModCore" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModCredentials -Value "Push-ModCredentials" -Description "Push-location $env:ModCredentials" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModCryptography -Value "Push-ModCryptography" -Description "Push-location $env:ModCryptography" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModDownloader -Value "Push-ModDownloader" -Description "Push-location $env:ModDownloader" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModFedEx -Value "Push-ModFedEx" -Description "Push-location $env:ModFedEx" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModGithub -Value "Push-ModGithub" -Description "Push-location $env:ModGithub" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModNetwork -Value "Push-ModNetwork" -Description "Push-location $env:ModNetwork" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModNtRights -Value "Push-ModNtRights" -Description "Push-location $env:ModNtRights" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModReddit -Value "Push-ModReddit" -Description "Push-location $env:ModReddit" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModSetAcl -Value "Push-ModSetAcl" -Description "Push-location $env:ModSetAcl" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModShim -Value "Push-ModShim" -Description "Push-location $env:ModShim" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModSystemConfigurator -Value "Push-ModSystemConfigurator" -Description "Push-location $env:ModSystemConfigurator" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModTakeOwnership -Value "Push-ModTakeOwnership" -Description "Push-location $env:ModTakeOwnership" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModTemplate -Value "Push-ModTemplate" -Description "Push-location $env:ModTemplate" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModTerminal -Value "Push-ModTerminal" -Description "Push-location $env:ModTerminal" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModWindowsConfiguration -Value "Push-ModWindowsConfiguration" -Description "Push-location $env:ModWindowsConfiguration" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
New-Alias ModWindowsHost -Value "Push-ModWindowsHost" -Description "Push-location $env:ModWindowsHost" -Scope Global -Force -ErrorAction Stop -Option ReadOnly,AllScope
