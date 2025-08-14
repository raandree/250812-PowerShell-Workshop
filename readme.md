# 1. PowerShell Workshop - August 12, 2025

- [1. PowerShell Workshop - August 12, 2025](#1-powershell-workshop---august-12-2025)
  - [1.1. 📋 Workshop Contents](#11--workshop-contents)
    - [1.1.1. Scripts in This Repository](#111-scripts-in-this-repository)
  - [1.2. 🔧 Key PowerShell Concepts Covered](#12--key-powershell-concepts-covered)
    - [1.2.1. Add-Type for Custom Types](#121-add-type-for-custom-types)
    - [1.2.2. Null Comparison Best Practices](#122-null-comparison-best-practices)
    - [1.2.3. Advanced Group-Object Usage](#123-advanced-group-object-usage)
    - [1.2.4. Regular Expressions](#124-regular-expressions)
    - [1.2.5. Splatting Parameters](#125-splatting-parameters)
    - [1.2.6. Copilot](#126-copilot)
    - [Pester](#pester)
    - [DSC](#dsc)
- [TODO: in DSC](#todo-in-dsc)
    - [Debugging PowerShell Processes](#debugging-powershell-processes)
    - [Configuration and Logging with PSFramework](#configuration-and-logging-with-psframework)
    - [Parallel processing with ForEach-Object and ThreadJobs](#parallel-processing-with-foreach-object-and-threadjobs)
    - [1.2.7. Parallel Processing with Split-Pipeline](#127-parallel-processing-with-split-pipeline)
  - [1.3. 🔗 Additional Resources](#13--additional-resources)
    - [1.3.1. PowerShell Community Tools](#131-powershell-community-tools)
    - [1.3.2. Learning Resources](#132-learning-resources)
  - [1.4. 🚀 Getting Started](#14--getting-started)
  - [1.5. 📝 Workshop Exercises](#15--workshop-exercises)
  - [1.6. 🤝 Contributing](#16--contributing)

Welcome to the PowerShell Workshop! This repository contains practical examples and exercises to help you master PowerShell scripting fundamentals.

## 1.1. 📋 Workshop Contents

### 1.1.1. Scripts in This Repository

| Script | Description |
|--------|-------------|
| `foreach.ps1` | Demonstrates different foreach loop patterns and nested iterations |
| `ErrorHandling.ps1` | Shows error handling techniques using try-catch blocks and error actions |

## 1.2. 🔧 Key PowerShell Concepts Covered

### 1.2.1. Add-Type for Custom Types

Learn how to add custom .NET types to PowerShell for advanced functionality, particularly useful for SSL certificate handling:

```powershell
# Example: Adding custom certificate policy (PowerShell 5.1)
if ($PSEdition -eq 'Desktop') {
    Add-Type @"
        using System.Net;
        using System.Security.Cryptography.X509Certificates;
        public class TrustAllCertsPolicy : ICertificatePolicy {
            public bool CheckValidationResult(
                ServicePoint srvPoint, X509Certificate certificate,
                WebRequest request, int certificateProblem) {
                return true;
            }
        }
"@
    [System.Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
}

# PowerShell 7+ alternative
if ($PSVersionTable.PSVersion.Major -ge 6) {
    # Use -SkipCertificateCheck parameter instead
    Invoke-WebRequest -Uri "https://example.com" -SkipCertificateCheck
}
```

**Resources:**

- [SSL Certificate Handling Gist](https://gist.github.com/jmassardo/2e0dd7cce292f16ff8f6945b8b3752b5)

### 1.2.2. Null Comparison Best Practices

Always compare with `$null` on the left side to avoid unexpected behavior:

```powershell
# ✅ CORRECT - null on the left
$f = New-Object System.Collections.ArrayList
$f.Add((Get-Item C:\Windows1\ -ErrorAction SilentlyContinue))

if ($null -eq $f) {
    Write-Host "Folder does not exist"
} else {
    Write-Host "Folder exists"
}

# ❌ WRONG - null on the right (can cause issues with arrays)
if ($f -eq $null) {
    # This might not work as expected with collections
}
```

### 1.2.3. Advanced Group-Object Usage

The `-Property` parameter accepts script blocks for dynamic grouping:

```powershell
# Group files by year and month
Get-ChildItem -Recurse -File | 
    Group-Object -Property { $_.LastWriteTime.ToString('yyyy MMMM') } | 
    Sort-Object -Property Name -Descending

# Random sorting demonstration
1..20 | Sort-Object -Descending -Property { Get-Random }
```

### 1.2.4. Regular Expressions

> *"Some people, when confronted with a problem, think 'I know, I'll use regular expressions.' Now they have two problems."* - Jamie Zawinski

Regular expressions are powerful but should be used judiciously:

```powershell
# Example: Simple email validation
$email = "user@example.com"
if ($email -match "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$") {
    Write-Host "Valid email format"
}

# Complex regex with comments (using IgnorePatternWhitespace)
$htmlPattern = @"
(?x)                    # Enable comments and whitespace
</?p>|                  # Paragraph tags
<br\s?/?>|             # Break tags (with optional space and slash)
</?b>|                  # Bold tags
</?strong>|             # Strong tags
</?i>|                  # Italic tags
</?em>                  # Emphasis tags
"@
```

**Best Practices for Regex:**

1. Don't try to do everything in one uber-regex
2. Use whitespace and comments with `(?x)` flag
3. Test regex patterns with tools like RegexBuddy
4. Remember: regex are not parsers - use proper parsers for complex structures

**Resources:**

- [Jeff Atwood's Regex Article](https://blog.codinghorror.com/regular-expressions-now-you-have-two-problems/)

### 1.2.5. Splatting Parameters

Splatting makes function calls cleaner and more maintainable:

```powershell
# Without splatting (hard to read)
Invoke-WebRequest -Uri "https://api.example.com/data" -Method POST -Headers @{"Authorization"="Bearer token"} -Body $jsonData -ContentType "application/json"

# With splatting (much cleaner)
$webRequestParams = @{
    Uri         = "https://api.example.com/data"
    Method      = "POST"
    Headers     = @{"Authorization" = "Bearer token"}
    Body        = $jsonData
    ContentType = "application/json"
}
Invoke-WebRequest @webRequestParams

# Function parameter splatting
function New-User {
    param(
        [string]$Name,
        [string]$Email,
        [string]$Department,
        [string]$Title
    )
    # Function logic here
}

$userParams = @{
    Name       = "John Doe"
    Email      = "john.doe@company.com"
    Department = "IT"
    Title      = "Developer"
}
New-User @userParams
```

### 1.2.6. Copilot

https://code.visualstudio.com/docs/copilot/chat/chat-agent-mode

Chat › Tools: Auto Approve

Chat › Agent: Max Requests (500)

[Software Engineer v1.chatmode](./Software%20Engineer%20v1.chatmode.md) Extended coding agent more with memory bank

Concepte of memory bank in AI

### Pester

Sample for infrastructure testing [TestLocalMachine.tests.ps1](./Pester%20Infrastructure%20Testing//TestLocalMachine.tests.ps1).

Output NUnit can be integrated into all CI tools to get a visualization.

Use Copilot for writing tests.

### DSC

Samples:
# TODO: in [DSC](./DSC/DSC%201.ps1)

https://github.com/microsoft/PowerStig

### Debugging PowerShell Processes

https://gist.github.com/raandree/5e675d28ccc72cb55ab3808007bda5f4

[Scheduled Jobs and Debugging.ps1](./Debugging%20a%20Schedules%20Job//Scheduled%20Jobs%20and%20Debugging.ps1)

### Configuration and Logging with PSFramework

```powershell
Get-LabConfigurationItem

Get-LabConfigurationItem -Name MaxPSSessionsPerVM

Get-PSFConfig -Module AutomatedLab

Register-PSFConfig -Module AutomatedLab -Name aaTest1 -Scope 

Set-PSFConfig -Module AutomatedLab -Name aaTest1 -Value 123 -Description None

```

### Parallel processing with ForEach-Object and ThreadJobs

`ForEach-Object -Parallel` only available in PowerShell 7.

1..100 | ForEach-Object { Start-Sleep -Milliseconds 100 }

1..100 | ForEach-Object -Parallel { Start-Sleep -Milliseconds 100 } -ThrottleLimit 24

Alternative [ThreadJob](https://github.com/PowerShell/ThreadJob).

$sb = { Start-Sleep -Milliseconds 2000 }

$j = 1..100 | ForEach-Object { Start-ThreadJob -ScriptBlock $sb -ThrottleLimit 24 }

in depth talk: https://www.youtube.com/watch?v=U1eihsrazAA



### 1.2.7. Parallel Processing with Split-Pipeline

Split-Pipeline is a powerful module that enables parallel processing in PowerShell, significantly speeding up operations that can be parallelized:

```powershell
# Install Split-Pipeline module (run once)
Install-Module SplitPipeline -Scope CurrentUser

# Example 1: Parallel file processing
# Sequential processing (slow for large datasets)
$files = Get-ChildItem -Path "C:\LargeFolder" -Recurse -File
$results = $files | ForEach-Object {
    Get-FileHash $_.FullName -Algorithm SHA256
}

# Parallel processing (much faster)
$files = Get-ChildItem -Path "C:\LargeFolder" -Recurse -File
$results = $files | Split-Pipeline -Count 8 {
    process { Get-FileHash $_.FullName -Algorithm SHA256 }
}

# Example 2: Parallel web requests
$urls = @(
    "https://httpbin.org/delay/2"
    "https://httpbin.org/delay/3"
    "https://httpbin.org/delay/1"
    "https://httpbin.org/delay/4"
)

# Sequential: ~10 seconds total
Measure-Command {
    $sequential = $urls | ForEach-Object {
        Invoke-RestMethod -Uri $_ -TimeoutSec 30
    }
}

# Parallel: ~4 seconds total (fastest request time)
Measure-Command {
    $parallel = $urls | Split-Pipeline -Count 4 {
        process { 
            Invoke-RestMethod -Uri $_ -TimeoutSec 30
        }
    }
}

# Example 3: Parallel data processing with custom functions
$servers = @("google.com", "microsoft.com", "github.com", "stackoverflow.com")

# Test multiple servers in parallel
$connectivityResults = $servers | Split-Pipeline -Count 4 {
    process { 
        $serverName = $_
        
        # Test basic connectivity
        $pingResult = Test-Connection -ComputerName $serverName -Count 1 -Quiet -ErrorAction SilentlyContinue
        
        # Test specific ports
        $port80Result = $false
        $port443Result = $false
        
        try {
            $port80Test = Test-NetConnection -ComputerName $serverName -Port 80 -WarningAction SilentlyContinue
            $port80Result = $port80Test.TcpTestSucceeded
        } catch {
            $port80Result = $false
        }
        
        try {
            $port443Test = Test-NetConnection -ComputerName $serverName -Port 443 -WarningAction SilentlyContinue
            $port443Result = $port443Test.TcpTestSucceeded
        } catch {
            $port443Result = $false
        }
        
        # Return results
        [PSCustomObject]@{
            Server = $serverName
            Ping = $pingResult
            Port80 = $port80Result
            Port443 = $port443Result
            Timestamp = Get-Date
        }
    }
} | Sort-Object Server

# Alternative: Using functions with Split-Pipeline
function Test-ServerConnectivity {
    param([string]$ServerName)
    
    $pingResult = Test-Connection -ComputerName $ServerName -Count 1 -Quiet -ErrorAction SilentlyContinue
    
    $port80Result = try {
        (Test-NetConnection -ComputerName $ServerName -Port 80 -WarningAction SilentlyContinue).TcpTestSucceeded
    } catch { $false }
    
    $port443Result = try {
        (Test-NetConnection -ComputerName $ServerName -Port 443 -WarningAction SilentlyContinue).TcpTestSucceeded
    } catch { $false }
    
    return [PSCustomObject]@{
        Server = $ServerName
        Ping = $pingResult
        Port80 = $port80Result
        Port443 = $port443Result
        Timestamp = Get-Date
    }
}

# Pass function to Split-Pipeline using -Function parameter
$connectivityResults2 = $servers | Split-Pipeline -Count 4 -Function Test-ServerConnectivity {
    process { 
        Test-ServerConnectivity -ServerName $_
    }
} | Sort-Object Server

# Example 4: Parallel log analysis
$logFiles = Get-ChildItem -Path "C:\Logs\*.log" -File

$errorAnalysis = $logFiles | Split-Pipeline -Count 6 {
    process {
        $errors = Select-String -Path $_.FullName -Pattern "ERROR|FATAL" -AllMatches
        [PSCustomObject]@{
            LogFile = $_.Name
            ErrorCount = $errors.Count
            LastError = ($errors | Select-Object -Last 1).Line
            FileSize = [math]::Round($_.Length / 1MB, 2)
        }
    }
} | Sort-Object ErrorCount -Descending
```

**Key Benefits of Split-Pipeline:**

- **Performance**: Dramatically reduces processing time for CPU-intensive or I/O-bound operations
- **Scalability**: Automatically manages worker processes and load balancing
- **Flexibility**: Works with any PowerShell pipeline operation
- **Resource Control**: Specify the number of parallel processes with `-Count` parameter

**Best Practices:**

1. **Choose optimal thread count**: Usually CPU cores × 2 for I/O operations, CPU cores for CPU-intensive tasks
2. **Consider overhead**: Parallel processing has setup costs - only beneficial for operations taking >100ms per item
3. **Handle shared resources carefully**: Avoid writing to the same files or shared variables
4. **Test performance**: Always measure to ensure parallel processing provides actual benefits

**Resources:**

- [Split-Pipeline on PowerShell Gallery](https://www.powershellgallery.com/packages/SplitPipeline)

## 1.3. 🔗 Additional Resources

### 1.3.1. PowerShell Community Tools

- **Join-Object**: [Custom function for joining PowerShell objects](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Join-Object.ps1)
- **Split-Pipeline**: Advanced pipeline processing for parallel execution

### 1.3.2. Learning Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [AI Future Predictions](https://ai-2027.com/) - Understanding the evolving tech landscape

## 1.4. 🚀 Getting Started

1. Clone this repository
2. Open PowerShell 5.1 or PowerShell 7+
3. Navigate to the workshop directory
4. Run the example scripts:

   ```powershell
   .\foreach.ps1
   .\ErrorHandling.ps1
   ```

## 1.5. 📝 Workshop Exercises

Try these exercises to practice the concepts:

#TODO: further material on functions and modules https://github.com/raandree/PowerShellTraining/

1. **Foreach Loops**: Modify `foreach.ps1` to process different data types
2. **Error Handling**: Extend `ErrorHandling.ps1` with custom error types
3. **Splatting**: Create a function that uses splatting for parameter passing
4. **Regex**: Build a text processing script using regular expressions
5. **Custom Types**: Implement a custom .NET type for specific functionality

## 1.6. 🤝 Contributing

Feel free to submit improvements, additional examples, or corrections via pull requests.

---

Happy PowerShell scripting! 🎯


vorträge david kriegel

phoenix project

teams termin für DSC
