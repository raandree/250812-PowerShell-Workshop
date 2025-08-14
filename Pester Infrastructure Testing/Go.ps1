$PesterConfiguration = New-PesterConfiguration -Hashtable @{
    Run = @{
        Path = "$PSScriptRoot\TestLocalMachine.tests.ps1"
    }
    TestResult = @{
        Enabled = $true
        OutputPath = "$PSScriptRoot\PesterOutput.xml"
        OutputFormat = 'NUnitXML'
    }
}

Invoke-Pester -Configuration $PesterConfiguration