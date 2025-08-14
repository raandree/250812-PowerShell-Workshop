function f1
{
    Write-PSFMessage 'Calling internal function' -Level Host -Tag t1
    f2
}

function f2
{
    Write-PSFMessage 'Getting the date' -Level Host -Tag t1
    Get-Date
    try {
        $f = Get-Item C:\Windows1 -ErrorAction Stop
    }
    catch
    {
        Write-PSFMessage 'Something went wrong' -Level Error -ErrorRecord $_ -Data @{ EventId = 1; ID = 2 }
    }
    
}

$paramSetPSFLoggingProvider = @{
    Name         = 'logfile'
    InstanceName = '<taskname>'
    FilePath     = 'C:\Logs\TaskName-%Date%.csv'
    Enabled      = $true
    Wait         = $true
}
Set-PSFLoggingProvider @paramSetPSFLoggingProvider -EnableException

$paramSetPSFLoggingProvider = @{
    Name         = 'logfile'
    InstanceName = 'Error<taskname>'
    FilePath     = 'C:\Logs\TaskNameError-%Date%.csv'
    Enabled      = $true
    Wait         = $true
    MaxLevel = 1
}
Set-PSFLoggingProvider @paramSetPSFLoggingProvider -EnableException

$paramSetPSFLoggingProvider = @{
    Name         = 'eventlog'
    InstanceName = 'ErrorEventLog'
    Enabled      = $true
    Wait         = $true
    MaxLevel     = 1
}
Set-PSFLoggingProvider @paramSetPSFLoggingProvider -EnableException

Write-PSFMessage 'Starting' -Level Host -Tag t1

f1

Write-PSFMessage 'Done' -Level Host -Tag t1