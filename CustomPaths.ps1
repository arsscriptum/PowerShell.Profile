

# initialize the array
[PsObject[]]$paths = @()


Write-Host "initializing custom paths for $ENV:COMPUTERNAME" -f DarkCyan


if($ENV:COMPUTERNAME -eq 'DESKTOP-NCSJJE6'){
    # populate the array with each object
    $paths += [PsObject]@{ Name = "DevelopmentRoot"; Path = "P:\Development" }
    $paths += [PsObject]@{ Name = "Sandbox" ; Path = "P:\Development\PowerShell.Sandbox" }
    $paths += [PsObject]@{ Name = "ScriptsRoot" ; Path = "P:\Scripts" }
}


function Set-CustomPaths{
 [CmdletBinding(SupportsShouldProcess)]
    param()    

    # display all people
    Write-Host "Paths:"
    foreach($p in $Paths) {
        Write-Host "  - Name: '$($p.Name)', Path: $($p.Path)"
        [System.Environment]::SetEnvironmentVariable($Name,$Path,[System.EnvironmentVariableTarget]::User)
    }
    
}