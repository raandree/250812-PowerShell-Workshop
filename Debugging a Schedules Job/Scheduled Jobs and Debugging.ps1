$t = New-JobTrigger -At 12:00 -Once

$sb = {
    Get-Date
    
    $d = dir C:\Windows
    $PID | Out-File -FilePath C:\pid.txt
    Wait-Debugger
    
    $a = 1..50
    
    $a | ForEach-Object {
        "Test $_"
    }
}

#with 'Register-ScheduledJob' job definitions are stored in the local user's profile
#C:\Users\randr\AppData\Local\Microsoft\Windows\PowerShell\ScheduledJobs\Test1
Register-ScheduledJob -ScriptBlock $sb -Name Test1 -Trigger $t

<#shoud work
        Get-ScheduledTask -TaskPath '\Microsoft\Windows\PowerShell\ScheduledJobs' -TaskName Test1 |
        Start-ScheduledTask
#>

$r = Get-Job -Id 1 | Receive-Job -Keep

Get-ScheduledJob | Unregister-ScheduledJob -Force

#Debugging a PowerShell runspace in another process

Enter-PSHostProcess -Id 16796
$rs = Get-Runspace | Where-Object { $_.Debugger.InBreakpoint }
Debug-Runspace -Runspace $rs