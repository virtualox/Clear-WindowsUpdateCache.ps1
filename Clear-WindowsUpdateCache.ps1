<#
.SYNOPSIS
    Clears the Windows Update cache on Windows clients and servers.

.DESCRIPTION
    This PowerShell script stops the Windows Update service, removes the cache folder, and then restarts the service.
    It is designed to work on both Windows clients and servers, and requires administrative privileges to run.

.PARAMETER Confirm
    Prompts for confirmation before running the script. The default is set to $true.

.EXAMPLE
    .\Clear-WindowsUpdateCache.ps1 -Confirm $true

    Prompts the user for confirmation before running the script and clearing the Windows Update cache.

#>

param(
    [Parameter(Mandatory=$false)]
    [bool]$Confirm = $true
)

if ($Confirm -eq $true) {
    $userConfirmation = Read-Host "Are you sure you want to clear the Windows Update cache? (yes/no)"
    if ($userConfirmation -ne "yes") {
        Write-Host "Aborting the script."
        exit
    }
}

# Run the script with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "You do not have Administrator rights to run this script!`nPlease re-run this script as an Administrator."
    Start-Sleep -Seconds 3
    exit
}

# Stop the Windows Update service
Write-Host "Stopping the Windows Update service..."
Stop-Service -Name wuauserv -Force

# Remove the Windows Update cache
Write-Host "Removing the Windows Update cache..."
$UpdateCachePath = "$env:SystemRoot\SoftwareDistribution"
if (Test-Path $UpdateCachePath) {
    Remove-Item -Path $UpdateCachePath -Recurse -Force
} else {
    Write-Host "The Windows Update cache folder does not exist."
}

# Start the Windows Update service
Write-Host "Starting the Windows Update service..."
Start-Service -Name wuauserv

# Check the Windows Update service status
$UpdateService = Get-Service -Name wuauserv
if ($UpdateService.Status -eq "Running") {
    Write-Host "The Windows Update service is running."
} else {
    Write-Warning "The Windows Update service is not running. Please check the service status manually."
}

# Completion message
Write-Host "Windows Update cache has been cleared successfully."
