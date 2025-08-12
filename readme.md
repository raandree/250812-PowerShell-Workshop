# PowerShell Workshop - August 12, 2025

Welcome to the PowerShell Workshop! This repository contains practical examples and exercises to help you master PowerShell scripting fundamentals.

## 📋 Workshop Contents

### Scripts in This Repository

| Script | Description |
|--------|-------------|
| `foreach.ps1` | Demonstrates different foreach loop patterns and nested iterations |
| `ErrorHandling.ps1` | Shows error handling techniques using try-catch blocks and error actions |

## 🔧 Key PowerShell Concepts Covered

### 1. Add-Type for Custom Types

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

### 2. Null Comparison Best Practices

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

### 3. Advanced Group-Object Usage

The `-Property` parameter accepts script blocks for dynamic grouping:

```powershell
# Group files by year and month
Get-ChildItem -Recurse -File | 
    Group-Object -Property { $_.LastWriteTime.ToString('yyyy MMMM') } | 
    Sort-Object -Property Name -Descending

# Random sorting demonstration
1..20 | Sort-Object -Descending -Property { Get-Random }
```

### 4. Regular Expressions

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

### 5. Splatting Parameters

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

## 🔗 Additional Resources

### PowerShell Community Tools

- **Join-Object**: [Custom function for joining PowerShell objects](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Join-Object.ps1)
- **Split-Pipeline**: Advanced pipeline processing for parallel execution

### Learning Resources

- [PowerShell Documentation](https://docs.microsoft.com/en-us/powershell/)
- [PowerShell Gallery](https://www.powershellgallery.com/)
- [AI Future Predictions](https://ai-2027.com/) - Understanding the evolving tech landscape

## 🚀 Getting Started

1. Clone this repository
2. Open PowerShell 5.1 or PowerShell 7+
3. Navigate to the workshop directory
4. Run the example scripts:

   ```powershell
   .\foreach.ps1
   .\ErrorHandling.ps1
   ```

## 📝 Workshop Exercises

Try these exercises to practice the concepts:

1. **Foreach Loops**: Modify `foreach.ps1` to process different data types
2. **Error Handling**: Extend `ErrorHandling.ps1` with custom error types
3. **Splatting**: Create a function that uses splatting for parameter passing
4. **Regex**: Build a text processing script using regular expressions
5. **Custom Types**: Implement a custom .NET type for specific functionality

## 🤝 Contributing

Feel free to submit improvements, additional examples, or corrections via pull requests.

---

Happy PowerShell scripting! 🎯
