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
      - [1.2.6.1. Basic Copilot Configuration](#1261-basic-copilot-configuration)
      - [1.2.6.2. Advanced AI Agent Pattern: Software Engineer v1](#1262-advanced-ai-agent-pattern-software-engineer-v1)
      - [1.2.6.3. Why the Software Engineer v1 Mode is Important](#1263-why-the-software-engineer-v1-mode-is-important)
      - [1.2.6.4. Key Benefits for Enterprise Development](#1264-key-benefits-for-enterprise-development)
      - [1.2.6.5. The Memory Bank Concept in AI](#1265-the-memory-bank-concept-in-ai)
      - [1.2.6.6. Practical Workshop Application](#1266-practical-workshop-application)
      - [1.2.6.7. Implementation Tips](#1267-implementation-tips)
      - [1.2.6.8. Enterprise AI Strategy](#1268-enterprise-ai-strategy)
    - [1.2.7. Pester](#127-pester)
    - [1.2.8. DSC (Desired State Configuration)](#128-dsc-desired-state-configuration)
      - [1.2.8.1. Key DSC Concepts](#1281-key-dsc-concepts)
      - [1.2.8.2. Advanced DSC with Configuration Data](#1282-advanced-dsc-with-configuration-data)
      - [1.2.8.3. Enterprise DSC Resources](#1283-enterprise-dsc-resources)
      - [1.2.8.4. DSC Best Practices](#1284-dsc-best-practices)
      - [1.2.8.5. Workshop Examples](#1285-workshop-examples)
    - [1.2.9. Debugging PowerShell Processes](#129-debugging-powershell-processes)
      - [1.2.9.1. Debugging Scheduled Jobs](#1291-debugging-scheduled-jobs)
      - [1.2.9.2. Debugging Remote Runspaces](#1292-debugging-remote-runspaces)
      - [1.2.9.3. Key Debugging Commands](#1293-key-debugging-commands)
      - [1.2.9.4. Debugging Best Practices](#1294-debugging-best-practices)
      - [1.2.9.5. Workshop Example](#1295-workshop-example)
    - [1.2.10. Configuration and Logging with PSFramework](#1210-configuration-and-logging-with-psframework)
      - [1.2.10.1. Configuration Management](#12101-configuration-management)
      - [1.2.10.2. Advanced Logging with PSFramework](#12102-advanced-logging-with-psframework)
      - [1.2.10.3. Multi-Target Logging Configuration](#12103-multi-target-logging-configuration)
      - [1.2.10.4. Structured Logging Benefits](#12104-structured-logging-benefits)
      - [1.2.10.5. Message Levels](#12105-message-levels)
      - [1.2.10.6. Workshop Example](#12106-workshop-example)
      - [1.2.10.7. Best Practices](#12107-best-practices)
    - [1.2.11. Parallel Processing with ForEach-Object and ThreadJobs](#1211-parallel-processing-with-foreach-object-and-threadjobs)
      - [1.2.11.1. ForEach-Object -Parallel (PowerShell 7+)](#12111-foreach-object--parallel-powershell-7)
      - [1.2.11.2. Key Parameters for ForEach-Object -Parallel](#12112-key-parameters-for-foreach-object--parallel)
      - [1.2.11.3. ThreadJob Alternative (PowerShell 5.1 Compatible)](#12113-threadjob-alternative-powershell-51-compatible)
      - [1.2.11.4. Practical Examples](#12114-practical-examples)
      - [1.2.11.5. Performance Considerations](#12115-performance-considerations)
      - [1.2.11.6. Variable Scope in Parallel Processing](#12116-variable-scope-in-parallel-processing)
      - [1.2.11.7. Comparison with Other Approaches](#12117-comparison-with-other-approaches)
    - [1.2.12. Parallel Processing with Split-Pipeline](#1212-parallel-processing-with-split-pipeline)
  - [1.3. 🔗 Additional Resources](#13--additional-resources)
    - [1.3.1. PowerShell Community Tools](#131-powershell-community-tools)
    - [1.3.2. Learning Resources](#132-learning-resources)
  - [1.4. 🚀 Getting Started](#14--getting-started)
  - [1.5. 📝 Workshop Exercises](#15--workshop-exercises)
    - [1.5.1. Basic Exercises](#151-basic-exercises)
    - [1.5.2. Intermediate Exercises](#152-intermediate-exercises)
    - [1.5.3. Advanced Exercises](#153-advanced-exercises)
    - [1.5.4. Bonus Challenges](#154-bonus-challenges)
    - [1.5.5. Additional Learning Resources](#155-additional-learning-resources)
  - [1.6. 🤝 Contributing](#16--contributing)

Welcome to the PowerShell Workshop! This repository contains practical examples and exercises to help you master PowerShell scripting fundamentals.

## 1.1. 📋 Workshop Contents

### 1.1.1. Scripts in This Repository

| Script | Description |
|--------|-------------|
| `foreach.ps1` | Demonstrates different foreach loop patterns and nested iterations |
| `ErrorHandling.ps1` | Shows error handling techniques using try-catch blocks and error actions |
| `Get-SmallFile.ps1` | Example script for file operations and filtering |
| **Pester Infrastructure Testing/** | Directory containing Pester test examples |
| `TestLocalMachine.tests.ps1` | Infrastructure validation tests for system configuration |
| **DSC/** | Directory containing Desired State Configuration examples |
| `DSC 1.ps1` | Basic DSC configuration for system setup |
| `DSC 2.ps1` | Advanced DSC with configuration data and multiple nodes |
| **Debugging a Schedules Job/** | Directory with debugging examples |
| `Scheduled Jobs and Debugging.ps1` | Demonstrates debugging techniques for scheduled PowerShell jobs |
| **PSFramework Logging/** | Directory with logging framework examples |
| `PSFrameworkLogging.ps1` | Advanced logging and configuration management examples |

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

GitHub Copilot is Microsoft's AI-powered coding assistant that revolutionizes how developers write code. This workshop demonstrates both basic Copilot usage and advanced AI agent patterns for enterprise development.

#### 1.2.6.1. Basic Copilot Configuration

Essential VS Code settings for optimal Copilot experience:

- **Chat › Tools: Auto Approve** - Streamlines tool usage in chat interactions
- **Chat › Agent: Max Requests (500)** - Increases the limit for complex development sessions

#### 1.2.6.2. Advanced AI Agent Pattern: Software Engineer v1

The workshop includes a sophisticated AI agent definition in [`Software Engineer v1.chatmode.md`](./Software%20Engineer%20v1.chatmode.md) that transforms Copilot from a simple coding assistant into a comprehensive software engineering partner.

#### 1.2.6.3. Why the Software Engineer v1 Mode is Important

**1. Production-Ready Development**
The mode enforces enterprise-grade development practices:

- **Autonomous Execution**: Eliminates the constant "Would you like me to..." interruptions
- **Systematic Approach**: Follows a structured development cycle (Analyze → Design → Implement → Validate → Reflect → Handoff)
- **Quality Gates**: Ensures code meets production standards before proceeding

**2. Memory Bank System**
One of the most innovative features addresses AI's session-based memory limitations:

```text
Memory Bank Structure:
├── projectbrief.md      # Foundation requirements and scope
├── productContext.md    # Business context and user goals  
├── activeContext.md     # Current work focus and decisions
├── systemPatterns.md    # Architecture and design patterns
├── techContext.md       # Technology stack and constraints
└── progress.md          # Status, accomplishments, and next steps
```

**3. Comprehensive Documentation**
The agent automatically maintains detailed documentation throughout development:

- **Decision Records**: Every significant choice is documented with rationale
- **Quality Validation**: All code changes are verified against established criteria  
- **Progress Tracking**: Continuous documentation of what works and what doesn't

#### 1.2.6.4. Key Benefits for Enterprise Development

**Consistency Across Sessions**

- The Memory Bank ensures continuity even when AI context resets
- New team members can understand project state immediately
- Knowledge transfer becomes automatic and comprehensive

**Reduced Technical Debt**

- Enforced quality gates prevent shortcuts that create future problems
- Automatic testing and validation requirements
- Clear architectural decisions prevent drift

**Accelerated Development**

- Zero-confirmation execution eliminates back-and-forth delays
- Systematic approach reduces rework and debugging time
- Built-in best practices prevent common pitfalls

#### 1.2.6.5. The Memory Bank Concept in AI

This pattern addresses a fundamental challenge in AI-assisted development: **context preservation**. Traditional AI assistants lose context between sessions, requiring developers to repeatedly explain project details. The Memory Bank creates a persistent knowledge layer that:

1. **Captures Institutional Knowledge**: Business requirements, architectural decisions, and learned patterns
2. **Enables Handoffs**: New developers (human or AI) can quickly understand project state
3. **Prevents Knowledge Loss**: Critical decisions and rationale are preserved
4. **Accelerates Onboarding**: Comprehensive documentation reduces learning curves

#### 1.2.6.6. Practical Workshop Application

In PowerShell development, this pattern provides:

```powershell
# Example: The agent automatically documents PowerShell patterns
# Found in systemPatterns.md:

## PowerShell Patterns in Use
- **Splatting**: All complex function calls use parameter splatting
- **Error Handling**: Try-catch blocks with PSFramework logging
- **Parallel Processing**: ForEach-Object -Parallel for I/O operations
- **Testing**: Pester tests for all functions with infrastructure validation
```

#### 1.2.6.7. Implementation Tips

1. **Start Small**: Begin with basic Memory Bank files for existing projects
2. **Consistent Updates**: Update context files after significant changes  
3. **Team Adoption**: Share the pattern across development teams
4. **Tool Integration**: Combine with CI/CD pipelines for automatic documentation

#### 1.2.6.8. Enterprise AI Strategy

This approach represents a shift from "AI as tool" to "AI as team member":

- **Autonomous Operation**: AI handles routine tasks without constant supervision
- **Knowledge Retention**: Institutional knowledge is captured and preserved
- **Quality Assurance**: Built-in validation prevents quality degradation
- **Scalable Patterns**: Approaches work across languages and frameworks

The Software Engineer v1 mode demonstrates how proper AI agent design can transform development workflows, making them more efficient, consistent, and maintainable.

**Resources:**

- [VS Code Copilot Documentation](https://code.visualstudio.com/docs/copilot/chat/chat-agent-mode)
- [Software Engineer v1.chatmode](./Software%20Engineer%20v1.chatmode.md) - Complete agent specification

### 1.2.7. Pester

Pester is the de facto standard testing framework for PowerShell. It provides a powerful and flexible way to write unit tests, integration tests, and infrastructure validation tests.

**Infrastructure Testing Example**

The workshop includes a practical example of infrastructure testing with [TestLocalMachine.tests.ps1](./Pester%20Infrastructure%20Testing//TestLocalMachine.tests.ps1). This demonstrates how to validate system configuration and services:

```powershell
Describe "Testing local machine settings" {
    Context 'Time Settings' {
        It "Should have the correct time zone" {
            $expectedTimeZone = 'W. Europe Standard Time'
            $currentTimeZone = (Get-TimeZone).Id
            $currentTimeZone | Should -Be $expectedTimeZone
        }

        It "Is the Windows Time Service enabled?" {
            $service = Get-Service -Name w32time -ErrorAction SilentlyContinue
            $service | Should -Not -BeNullOrEmpty
            $service.Status | Should -Be 'Running'
        }

        It "NTP Server is configured correctly" {
            $settings = w32tm /query /peers
            $settings = $settings -join "`n"
            $settings | Should -Not -BeNullOrEmpty
            $settings | Should -BeLike '*time.windows.com*'
        }
    }
}
```

**Common Infrastructure Tests:**

- **Service Status**: Verify critical services are running
- **Network Configuration**: Validate IP settings, DNS, and connectivity
- **Disk Space**: Check available storage on critical drives
- **Security Settings**: Validate firewall rules and security policies
- **Application Configuration**: Test application-specific settings

**CI/CD Integration**

Pester tests output can be exported in NUnit XML format, making them perfect for CI/CD pipelines:

```powershell
# Run tests and export results for CI/CD
Invoke-Pester -Path ".\Tests\" -OutputFile "TestResults.xml" -OutputFormat NUnitXml

# Run with code coverage (PowerShell 5.1)
Invoke-Pester -Path ".\Tests\" -CodeCoverage ".\Source\*.ps1" -OutputFile "TestResults.xml" -OutputFormat NUnitXml
```

**Test Visualization with PesterOutput.xml**

The workshop includes a sample [`PesterOutput.xml`](./PesterOutput.xml) file that demonstrates the structured XML format Pester generates. This XML output is crucial for CI/CD integration because:

1. **Universal Compatibility**: The NUnit XML format is supported by virtually all CI/CD platforms (Azure DevOps, GitHub Actions, Jenkins, GitLab CI, etc.)

2. **Rich Test Reporting**: CI/CD tools can parse the XML to provide:
   - Visual test result dashboards
   - Pass/fail trends over time
   - Detailed failure analysis with stack traces
   - Test duration metrics and performance tracking

3. **Automated Quality Gates**: XML results enable automated decisions:
   - Block deployments when tests fail
   - Set coverage thresholds that must be met
   - Generate alerts for test regressions

4. **Team Visibility**: Transform PowerShell test results into accessible reports that non-technical stakeholders can understand

Example of how Azure DevOps displays Pester XML results:
- Test summary with pass/fail counts
- Individual test case details with execution times
- Failure reasons and error messages
- Historical trend analysis across builds

This makes PowerShell testing a first-class citizen in enterprise DevOps workflows, providing the same level of visibility and automation as other programming languages.

**Best Practices:**

1. **Structure**: Use `Describe`, `Context`, and `It` blocks for clear test organization
2. **BeforeAll/AfterAll**: Set up and tear down test environments
3. **Mocking**: Use `Mock` to isolate units under test
4. **Data-Driven Tests**: Use `TestCases` for parameterized testing
5. **Assertions**: Use descriptive assertion messages

**Resources:**

- [Pester Documentation](https://pester.dev/)
- Use GitHub Copilot for generating comprehensive test suites

### 1.2.8. DSC (Desired State Configuration)

PowerShell Desired State Configuration (DSC) is a declarative management platform that allows you to configure and maintain the state of your systems. DSC enables you to define how systems should be configured rather than writing scripts that perform specific actions.

#### 1.2.8.1. Key DSC Concepts

**Configuration**: A PowerShell function that defines the desired state of one or more systems:

```powershell
configuration BaseOS {
    Import-DscResource -ModuleName NetworkingDsc

    WindowsFeature PrintServer {
        Name = 'Print-Server'
        Ensure = 'Present'
    }

    File TestFile1 {
        DestinationPath = 'C:\TestFile1.txt'
        Contents = '123'
        Type = 'File'
    }

    IPAddress ip {
        IPAddress = '192.168.111.80'
        InterfaceAlias = 'DscWorkshop 0'
        AddressFamily = 'IPv4'
    }
}

# Compile and apply configuration
BaseOS -OutputPath C:\DSC
Start-DscConfiguration -Path C:\DSC -Wait -Verbose
```

#### 1.2.8.2. Advanced DSC with Configuration Data

For managing multiple nodes with different settings, use Configuration Data:

```powershell
configuration BaseOS {
    Import-DscResource -ModuleName NetworkingDsc

    node $ConfigurationData.AllNodes.NodeName {
        WindowsFeature PrintServer {
            Name = 'Print-Server'
            Ensure = 'Present'
        }

        IPAddress ip {
            IPAddress = $ConfigurationData."$NodeName".Network.IpAddress
            InterfaceAlias = 'DscWorkshop 0'
            AddressFamily = 'IPv4'
        }
    }
}

# Configuration data separates environment-specific values
$configData = @{
    AllNodes = @(
        @{ NodeName = 'DSCHost01' }
        @{ NodeName = 'DSCFile01' }
    )
    'DSCHost01' = @{
        Network = @{ IpAddress = '192.168.111.80' }
    }
    'DSCFile01' = @{
        Network = @{ IpAddress = '192.168.111.100' }
    }
}

BaseOS -OutputPath C:\DSC -ConfigurationData $configData
```

#### 1.2.8.3. Enterprise DSC Resources

**PowerSTIG**: Microsoft's Security Technical Implementation Guide (STIG) as DSC configurations:

- [PowerSTIG on GitHub](https://github.com/microsoft/PowerStig)
- Provides pre-built security configurations for Windows systems
- Implements DoD security requirements through DSC

#### 1.2.8.4. DSC Best Practices

1. **Idempotency**: DSC resources should be idempotent - running multiple times produces the same result
2. **Resource Modules**: Use community modules from PowerShell Gallery for common tasks
3. **Configuration Data**: Separate environment-specific data from configuration logic
4. **Testing**: Test configurations in isolated environments before production deployment
5. **Version Control**: Store configurations and data in source control

#### 1.2.8.5. Workshop Examples

The workshop includes two DSC examples:

- **[DSC 1.ps1](./DSC/DSC%201.ps1)**: Basic configuration setup
- **[DSC 2.ps1](./DSC/DSC%202.ps1)**: Advanced configuration with configuration data

**Useful DSC Commands:**

```powershell
# Check current configuration status
Get-DscConfiguration

# Test if system matches desired state
Test-DscConfiguration

# Get local configuration manager settings
Get-DscLocalConfigurationManager

# Remove a configuration
Remove-DscConfigurationDocument -Stage Current
```

### 1.2.9. Debugging PowerShell Processes

PowerShell provides powerful debugging capabilities for troubleshooting scripts and scheduled jobs. This is especially useful when working with background processes, scheduled tasks, or runspaces.

#### 1.2.9.1. Debugging Scheduled Jobs

Scheduled jobs run in separate PowerShell processes, making them challenging to debug. Here's how to set up debugging for scheduled jobs:

```powershell
# Create a scheduled job with debugging capability
$trigger = New-JobTrigger -At 12:00 -Once

$scriptBlock = {
    Get-Date
    $PID | Out-File -FilePath C:\pid.txt
    
    # Wait for debugger to attach
    Wait-Debugger
    
    $data = 1..50
    $data | ForEach-Object {
        "Processing item $_"
    }
}

# Register the scheduled job
Register-ScheduledJob -ScriptBlock $scriptBlock -Name "DebugTest" -Trigger $trigger
```

#### 1.2.9.2. Debugging Remote Runspaces

When debugging PowerShell processes running in different runspaces:

```powershell
# Find the process ID from the scheduled job output
$processId = Get-Content C:\pid.txt

# Enter the PowerShell host process
Enter-PSHostProcess -Id $processId

# Find runspaces that are in breakpoint state
$runspace = Get-Runspace | Where-Object { $_.Debugger.InBreakpoint }

# Attach debugger to the specific runspace
Debug-Runspace -Runspace $runspace

# Now you can use standard debugging commands:
# - Step-Over (or 'v')
# - Step-Into (or 's') 
# - Step-Out (or 'o')
# - Continue (or 'c')
# - Get variables with Get-Variable
# - Examine call stack with Get-PSCallStack
```

#### 1.2.9.3. Key Debugging Commands

```powershell
# Set breakpoints in scripts
Set-PSBreakpoint -Script "C:\Scripts\MyScript.ps1" -Line 10

# Set conditional breakpoints
Set-PSBreakpoint -Script "C:\Scripts\MyScript.ps1" -Line 15 -Condition '$counter -gt 5'

# Set variable access breakpoints
Set-PSBreakpoint -Variable "criticalVar" -Mode Write

# List all breakpoints
Get-PSBreakpoint

# Remove breakpoints
Remove-PSBreakpoint -Id 1
```

#### 1.2.9.4. Debugging Best Practices

1. **Use Wait-Debugger**: Add `Wait-Debugger` in scheduled jobs or background processes
2. **Log Process IDs**: Always log `$PID` to identify which process to attach to
3. **Conditional Breakpoints**: Use conditions to break only when specific criteria are met
4. **PowerShell ISE vs VS Code**: Both support debugging, but VS Code has more advanced features
5. **Remote Debugging**: Use `Enter-PSSession` combined with debugging for remote troubleshooting

#### 1.2.9.5. Workshop Example

The workshop includes a complete example in [Scheduled Jobs and Debugging.ps1](./Debugging%20a%20Schedules%20Job//Scheduled%20Jobs%20and%20Debugging.ps1) that demonstrates:

- Creating a scheduled job with debugging hooks
- Attaching to the process
- Stepping through code execution
- Cleaning up scheduled jobs

**Additional Resources:**

- [PowerShell Debugging Gist](https://gist.github.com/raandree/5e675d28ccc72cb55ab3808007bda5f4) - Advanced debugging techniques

### 1.2.10. Configuration and Logging with PSFramework

PSFramework is a powerful PowerShell module that provides enterprise-grade logging, configuration management, and other infrastructure features for PowerShell scripts and modules.

#### 1.2.10.1. Configuration Management

PSFramework provides a robust configuration system that persists settings across PowerShell sessions:

```powershell
# View all configuration items for a module
Get-PSFConfig -Module AutomatedLab

# Get specific configuration values
Get-PSFConfig -Name MaxPSSessionsPerVM

# Register new configuration settings
Register-PSFConfig -Module AutomatedLab -Name aaTest1 -Scope UserDefault -Value 100 -Description "Test configuration setting"

# Set configuration values
Set-PSFConfig -Module AutomatedLab -Name aaTest1 -Value 123 -Description "Updated test value"

# Configuration scopes (in order of precedence):
# - Runspace (temporary, current session only)
# - User (current user profile)
# - System (all users on machine)
# - FileUserLocal (user-specific file)
# - FileUserShared (shared user file)
# - FileSystem (system-wide file)
```

#### 1.2.10.2. Advanced Logging with PSFramework

PSFramework provides structured logging that's far more powerful than `Write-Host` or `Write-Output`:

```powershell
function Get-ProcessInfo {
    param([string]$ProcessName)
    
    Write-PSFMessage 'Starting process information gathering' -Level Host -Tag 'ProcessInfo'
    
    try {
        $processes = Get-Process -Name $ProcessName -ErrorAction Stop
        Write-PSFMessage "Found $($processes.Count) processes named $ProcessName" -Level Host -Tag 'ProcessInfo'
        return $processes
    }
    catch {
        Write-PSFMessage 'Failed to retrieve process information' -Level Error -ErrorRecord $_ -Data @{ 
            ProcessName = $ProcessName
            EventId = 1001
            RequestId = (New-Guid)
        }
        throw
    }
}
```

#### 1.2.10.3. Multi-Target Logging Configuration

Configure multiple logging providers for different purposes:

```powershell
# Main log file (all messages)
$logFileParams = @{
    Name         = 'logfile'
    InstanceName = 'MainLog'
    FilePath     = 'C:\Logs\Application-%Date%.csv'
    Enabled      = $true
    Wait         = $true
}
Set-PSFLoggingProvider @logFileParams

# Error-only log file
$errorLogParams = @{
    Name         = 'logfile'
    InstanceName = 'ErrorLog'
    FilePath     = 'C:\Logs\ApplicationError-%Date%.csv'
    Enabled      = $true
    Wait         = $true
    MaxLevel     = 1  # Only Error and Critical levels
}
Set-PSFLoggingProvider @errorLogParams

# Windows Event Log for errors
$eventLogParams = @{
    Name         = 'eventlog'
    InstanceName = 'ErrorEventLog'
    Enabled      = $true
    Wait         = $true
    MaxLevel     = 1
}
Set-PSFLoggingProvider @eventLogParams
```

#### 1.2.10.4. Structured Logging Benefits

PSFramework logging provides several advantages over traditional logging:

1. **Structured Data**: Log entries include metadata, tags, and custom data
2. **Multiple Targets**: Send logs to files, event logs, databases, or custom targets
3. **Performance**: Asynchronous logging doesn't block script execution
4. **Filtering**: Configure different log levels for different outputs
5. **Formatting**: Automatic formatting and CSV/JSON export capabilities

#### 1.2.10.5. Message Levels

PSFramework uses standardized message levels:

- **Critical**: System failure, requires immediate attention
- **Error**: Error conditions that don't stop execution
- **Warning**: Warning conditions
- **Host**: Important information (like Write-Host)
- **Significant**: Notable events
- **Output**: Normal output
- **Debug**: Debugging information
- **Verbose**: Detailed information

#### 1.2.10.6. Workshop Example

The [PSFrameworkLogging.ps1](./PSFramework%20Logging/PSFrameworkLogging.ps1) demonstrates:

```powershell
function ProcessData {
    Write-PSFMessage 'Starting data processing' -Level Host -Tag 'DataProcess'
    
    try {
        $file = Get-Item C:\NonExistentFile -ErrorAction Stop
    }
    catch {
        Write-PSFMessage 'File not found' -Level Error -ErrorRecord $_ -Data @{ 
            EventId = 2001
            FileName = 'C:\NonExistentFile'
            Timestamp = Get-Date
        }
    }
}
```

#### 1.2.10.7. Best Practices

1. **Use Tags**: Categorize messages with meaningful tags
2. **Include Context**: Add relevant data to error messages
3. **Appropriate Levels**: Choose the correct message level
4. **Structured Data**: Include machine-readable data for automated processing
5. **Performance**: Use asynchronous logging for production scripts

**Resources:**

- [PSFramework Documentation](https://psframework.org/)
- [PSFramework on PowerShell Gallery](https://www.powershellgallery.com/packages/PSFramework)

### 1.2.11. Parallel Processing with ForEach-Object and ThreadJobs

PowerShell offers several approaches to parallel processing, significantly improving performance for I/O-bound and CPU-intensive operations.

#### 1.2.11.1. ForEach-Object -Parallel (PowerShell 7+)

The `-Parallel` parameter is the modern approach to parallel processing in PowerShell 7:

```powershell
# Sequential processing (slow)
Measure-Command {
    1..100 | ForEach-Object { 
        Start-Sleep -Milliseconds 100 
    }
}
# Takes approximately 10 seconds

# Parallel processing (much faster)
Measure-Command {
    1..100 | ForEach-Object -Parallel { 
        Start-Sleep -Milliseconds 100 
    } -ThrottleLimit 10
}
# Takes approximately 1 second with 10 parallel threads
```

#### 1.2.11.2. Key Parameters for ForEach-Object -Parallel

```powershell
1..50 | ForEach-Object -Parallel {
    # Process each item in parallel
    $item = $_
    
    # Simulate work
    Start-Sleep -Milliseconds (Get-Random -Minimum 100 -Maximum 500)
    
    # Return result
    "Processed item $item in thread $($_.GetHashCode())"
} -ThrottleLimit 8  # Limit to 8 concurrent threads
```

#### 1.2.11.3. ThreadJob Alternative (PowerShell 5.1 Compatible)

For environments still using PowerShell 5.1, use the ThreadJob module:

```powershell
# Install ThreadJob module (run once)
Install-Module ThreadJob -Scope CurrentUser

# Create script block for parallel execution
$scriptBlock = { 
    param($Number)
    Start-Sleep -Milliseconds 200
    "Processed: $Number"
}

# Start multiple thread jobs
$jobs = 1..20 | ForEach-Object { 
    Start-ThreadJob -ScriptBlock $scriptBlock -ArgumentList $_ -ThrottleLimit 5
}

# Wait for completion and collect results
$results = $jobs | Wait-Job | Receive-Job

# Clean up jobs
$jobs | Remove-Job
```

#### 1.2.11.4. Practical Examples

**File Processing:**

```powershell
# Get all log files and process them in parallel
$logFiles = Get-ChildItem -Path "C:\Logs\*.log" -File

$results = $logFiles | ForEach-Object -Parallel {
    $file = $_
    $errorCount = (Select-String -Path $file.FullName -Pattern "ERROR" -AllMatches).Count
    $warningCount = (Select-String -Path $file.FullName -Pattern "WARNING" -AllMatches).Count
    
    [PSCustomObject]@{
        FileName = $file.Name
        Size = [math]::Round($file.Length / 1MB, 2)
        ErrorCount = $errorCount
        WarningCount = $warningCount
        ProcessedBy = $env:COMPUTERNAME
        ThreadId = [System.Threading.Thread]::CurrentThread.ManagedThreadId
    }
} -ThrottleLimit 6
```

**Web Service Testing:**

```powershell
$endpoints = @(
    "https://httpbin.org/delay/1",
    "https://httpbin.org/delay/2", 
    "https://httpbin.org/delay/3",
    "https://jsonplaceholder.typicode.com/posts/1",
    "https://api.github.com/user"
)

$testResults = $endpoints | ForEach-Object -Parallel {
    $endpoint = $_
    $stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
    
    try {
        $response = Invoke-RestMethod -Uri $endpoint -TimeoutSec 10
        $status = "Success"
        $statusCode = 200
    }
    catch {
        $status = "Failed"
        $statusCode = $_.Exception.Response.StatusCode.value__
    }
    
    $stopwatch.Stop()
    
    [PSCustomObject]@{
        Endpoint = $endpoint
        Status = $status
        StatusCode = $statusCode
        ResponseTime = $stopwatch.ElapsedMilliseconds
        TestTime = Get-Date
    }
} -ThrottleLimit 5
```

#### 1.2.11.5. Performance Considerations

1. **Optimal Thread Count**:
   - CPU-bound tasks: Number of CPU cores
   - I/O-bound tasks: 2-4 times CPU cores
   - Test different values for your specific workload

2. **Memory Usage**: Each parallel thread consumes memory - monitor usage with large datasets

3. **Overhead**: Parallel processing has setup costs - only beneficial for operations taking >50-100ms

4. **Shared Resources**: Be careful with file access, database connections, or API rate limits

#### 1.2.11.6. Variable Scope in Parallel Processing

Variables from the parent scope are not automatically available in parallel script blocks:

```powershell
# This WON'T work - $globalVar is not available in parallel scope
$globalVar = "Hello"
1..5 | ForEach-Object -Parallel {
    Write-Output "$globalVar $_"  # $globalVar is null
}

# This WILL work - use $using: scope modifier
$globalVar = "Hello"
1..5 | ForEach-Object -Parallel {
    Write-Output "$using:globalVar $_"
}

# For complex objects, consider passing as parameters
function Process-Data {
    param($Config, $Item)
    # Process using $Config and $Item
}

$config = @{ Server = "localhost"; Database = "MyDB" }
1..10 | ForEach-Object -Parallel {
    Process-Data -Config $using:config -Item $_
}
```

#### 1.2.11.7. Comparison with Other Approaches

| Method | PowerShell Version | Use Case | Performance |
|--------|-------------------|----------|-------------|
| `ForEach-Object -Parallel` | 7+ | Modern preferred method | Excellent |
| `ThreadJob` | 5.1+ | Legacy compatibility | Good |
| `Workflow` | 5.1 (deprecated) | Legacy only | Good but deprecated |
| `Start-Job` | All | Background jobs | Poor (high overhead) |

**In-Depth Resource:**

- [PowerShell Parallel Processing Deep Dive](https://www.youtube.com/watch?v=U1eihsrazAA) - Comprehensive video explanation

### 1.2.12. Parallel Processing with Split-Pipeline

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

Try these exercises to practice the concepts covered in this workshop:

### 1.5.1. Basic Exercises

1. **ForEach Loops**:
   - Modify `foreach.ps1` to process different data types (arrays, hashtables, custom objects)
   - Create nested loops to process multi-dimensional data structures

2. **Error Handling**:
   - Extend `ErrorHandling.ps1` with custom error types using `throw` statements
   - Implement proper error logging using try-catch-finally blocks

3. **Splatting Practice**:
   - Create a function that accepts multiple parameters and demonstrates splatting
   - Build a configuration-driven script that uses splatting for different environments

### 1.5.2. Intermediate Exercises

4. **Regular Expressions**:
   - Build a log parsing script that extracts specific information using regex
   - Create a text validation function for email addresses, phone numbers, and IP addresses

5. **Custom Types**:
   - Implement a custom .NET type for certificate validation
   - Create a custom PowerShell class with methods and properties

6. **Pester Testing**:
   - Write comprehensive tests for your custom functions
   - Create infrastructure validation tests for your local environment
   - Set up automated testing with CI/CD integration

### 1.5.3. Advanced Exercises

7. **DSC Configuration**:
   - Create a DSC configuration for a web server setup
   - Implement environment-specific configurations using configuration data
   - Build a complete DSC solution with multiple node types

8. **Parallel Processing**:
   - Convert a sequential file processing script to use parallel processing
   - Implement a parallel web scraping solution with proper error handling
   - Compare performance between sequential and parallel approaches

9. **PSFramework Integration**:
   - Refactor existing scripts to use PSFramework logging
   - Set up comprehensive logging for a production script
   - Implement configuration management for script settings

10. **Debugging Workshop**:
    - Create a scheduled job with debugging capabilities
    - Practice remote debugging techniques
    - Set up conditional breakpoints for complex scenarios

### 1.5.4. Bonus Challenges

11. **Complete Solution**:
    - Build a comprehensive PowerShell module that incorporates all workshop concepts
    - Include proper error handling, logging, testing, and documentation
    - Implement both sequential and parallel processing options

12. **Real-World Application**:
    - Choose a real problem from your work environment
    - Apply workshop concepts to create a robust solution
    - Present your solution with proper documentation and tests

### 1.5.5. Additional Learning Resources

For more advanced PowerShell concepts and enterprise-level scripting:

- **Functions and Modules**: [PowerShell Training Repository](https://github.com/raandree/PowerShellTraining/) - Comprehensive training materials
- **Advanced Scripting**: Explore enterprise patterns and best practices
- **Community Resources**: Join PowerShell user groups and online communities

## 1.6. 🤝 Contributing

Feel free to submit improvements, additional examples, or corrections via pull requests.

---

Happy PowerShell scripting! 🎯

vorträge david kriegel

phoenix project

teams termin für DSC
