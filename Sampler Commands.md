# 1. Creating a PowerShell Project with Sampler

- [1. Creating a PowerShell Project with Sampler](#1-creating-a-powershell-project-with-sampler)
  - [1.1. Install Sampler](#11-install-sampler)
  - [1.2. Explore Sampler Commands](#12-explore-sampler-commands)
  - [1.3. Create a New Sample Module](#13-create-a-new-sample-module)
  - [1.4. Best Practices When Adding Functions](#14-best-practices-when-adding-functions)
  - [1.5. Building and Testing with Azure DevOps](#15-building-and-testing-with-azure-devops)
  - [1.6. Publishing Your Module](#16-publishing-your-module)
    - [1.6.1. PowerShell Gallery](#161-powershell-gallery)
    - [1.6.2. GitHub Release](#162-github-release)
  - [1.7. Sampler Build Configuration](#17-sampler-build-configuration)
  - [1.8. Trigger a preview and full release](#18-trigger-a-preview-and-full-release)


Sampler is a toolkit for building, testing, and releasing PowerShell modules using standardized templates and automation. It helps you quickly scaffold modules, enforce best practices, and integrate CI/CD pipelines.

## 1.1. Install Sampler
```powershell
Install-Module -Name Sampler -RequiredVersion 0.119.0-preview0002 -AllowPrerelease -Force
```

## 1.2. Explore Sampler Commands
```powershell
Get-Command -Module Sampler
```

## 1.3. Create a New Sample Module
```powershell
# Define parameters for New-SampleModule
$NewSampleModuleParams = @{
    ModuleName        = 'RaandreeSamplerTest2'
    DestinationPath   = 'D:\'
    ModuleType        = 'SimpleModule'
    ModuleAuthor      = 'Me'
    ModuleDescription = 'None'
    ModuleVersion     = '0.2.0'
    LicenseType       = 'MIT'
}
New-SampleModule @NewSampleModuleParams
```

## 1.4. Best Practices When Adding Functions
- Add documentation for every function (use comment-based help)
- Write Pester tests for each function

## 1.5. Building and Testing with Azure DevOps
1. Create a pipeline in Azure DevOps.
2. Point the pipeline to the `azure-pipelines.yml` file in your GitHub project.
3. Run the pipeline. By default, it will skip the publish task unless configured otherwise.

## 1.6. Publishing Your Module

### 1.6.1. PowerShell Gallery
1. Create an access token in PowerShell Gallery.
2. In Azure DevOps, add a pipeline variable named `GalleryApiToken`, paste the token, and mark it as secret.

### 1.6.2. GitHub Release
1. Create a GitHub access token.
2. In Azure DevOps, add a pipeline variable named `GitHubToken`, paste the token, and mark it as secret.

## 1.7. Sampler Build Configuration
According to the Sampler documentation, add the following section to your `build.yaml` file to include changelogs and release assets:

```yaml
GitHubConfig:
  GitHubFilesToAdd:
    - 'CHANGELOG.md'
  ReleaseAssets:
    - output/GCPolicyPackages/UserAmyNotPresent*.zip
  GitHubConfigUserName: myGitHubUserName
  GitHubConfigUserEmail: myEmail@address.com
  UpdateChangelogOnPrerelease: false
```

---
For more details, see the official [Sampler documentation](https://github.com/gaelcolas/Sampler) and [PowerShell Gallery publishing guide](https://docs.microsoft.com/powershell/gallery/publishing-guidelines/).

---


## 1.8. Trigger a Preview and Full Release

Sampler supports automated preview and full releases using GitHub and CI/CD pipelines. This section explains how to trigger both types of releases and best practices for managing your module lifecycle.

### Preview Release (Prerelease)

To trigger a preview (prerelease) build:

1. **Push a change to the `main` branch**
  - Use a pull request for code review and traceability.
  - Every push to `main` will automatically trigger a pipeline and publish a prerelease to GitHub and/or PowerShell Gallery (depending on your pipeline configuration).

**Tip:** Prereleases are useful for testing new features and sharing early versions with collaborators before a full release.

### Full Release (Stable)

To publish a stable (full) release:

1. **Create a version tag in Git**
  - Use semantic versioning (e.g., `v1.0.0`, `v0.2.0`).
  - Tag the commit you want to release:

  ```powershell
  git tag v0.2.0
  git push --tags
  ```

2. **Pipeline detects the tag**
  - The CI/CD pipeline will recognize the new tag and trigger a full release workflow.
  - This will publish the module as a stable release to GitHub and/or PowerShell Gallery.

**Best Practices:**
- Always update your changelog and module version before tagging a release.
- Use pull requests for all changes to ensure code quality and auditability.
- Test your module with prereleases before publishing a full release.

**Release Flow Diagram:**

```text
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│  Push to   │─────▶│  Pipeline   │─────▶│ Prerelease  │
│  main      │      │  runs       │      │ published   │
└─────────────┘      └─────────────┘      └─────────────┘
    │
    ▼
┌─────────────┐      ┌─────────────┐      ┌─────────────┐
│  Tag commit │─────▶│  Pipeline   │─────▶│ Full release│
│  (vX.Y.Z)   │      │  runs       │      │ published   │
└─────────────┘      └─────────────┘      └─────────────┘
```

For more details, see the [Sampler release documentation](https://github.com/gaelcolas/Sampler/wiki/Release-Process).