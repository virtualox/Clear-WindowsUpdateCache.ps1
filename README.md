# Clear Windows Update Cache Script

This PowerShell script clears the Windows Update cache on Windows clients and servers.

## Features

- Stops the Windows Update service
- Removes the cache folder
- Restarts the Windows Update service
- Prompts for confirmation before running (optional)

## System Requirements

- Windows client or server operating system (Windows 7/Server 2008 R2 or newer)
- PowerShell 3.0 or higher
- Administrative privileges on the target machine

## Usage

1. Open PowerShell with administrative privileges. You can do this by searching for "PowerShell" in the Start menu, right-clicking on "Windows PowerShell," and selecting "Run as administrator."
2. Navigate to the directory containing the **`Clear-WindowsUpdateCache.ps1`** script.
3. Run the script using the following command:

```powershell
.\Clear-WindowsUpdateCache.ps1 -Confirm $true
```

By default, the script will prompt for confirmation before running. To skip the confirmation prompt, use **`$false`** instead of **`$true`**.
