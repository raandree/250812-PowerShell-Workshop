function Get-FolderWithSimpleTesting {
    param (
        [string]$Path
    )

    $f = Get-Item $Path -ErrorAction SilentlyContinue

    if ($null -eq $f) { 
        Write-Host 'Folder does not exist'
    }
    else { 
        Write-Host 'Folder exists' #not a good practice, host messages cannot be treated as data
    }
}

function Get-FolderWithTryCatch {
    param (
        [string]$Path
    )

    try {
        $f = Get-Item -Path $Path -ErrorAction Stop
        Write-Host 'Folder exists'
    }
    catch {
        #Write-Error "Failed to retrieve folder information. Error: $_" -ErrorAction Stop
        throw "Failed to retrieve folder information. Error: $_"
        Write-Host 'Hello World' #not visible as throw stop the execution
    }
    finally {
        Write-Host 'Cleanup actions can be performed here.' -ForegroundColor Magenta
    }
}

Write-Host "Calling 'Get-FolderWithTryCatch -Path \"C:\Windows1\\\"'"
Get-FolderWithTryCatch -Path 'C:\Windows1\'
Write-Host 'Done'

