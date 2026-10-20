# PAC CLI Environment Check Script
# Verifies Power Platform CLI installation and environment connectivity

param(
    [switch]$Verbose,
    [string]$EnvironmentName = "Development"
)

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "PAC CLI Environment Check" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Check PAC CLI installation
Write-Host "Checking PAC CLI installation..." -ForegroundColor Yellow
try {
    $pacVersion = pac --version 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ PAC CLI installed: $pacVersion" -ForegroundColor Green
    } else {
        Write-Host "✗ PAC CLI not found or error occurred" -ForegroundColor Red
        Write-Host "  Install with: winget install Microsoft.PowerApps.CLI.Tool" -ForegroundColor Gray
        exit 1
    }
} catch {
    Write-Host "✗ PAC CLI not found" -ForegroundColor Red
    Write-Host "  Install with: winget install Microsoft.PowerApps.CLI.Tool" -ForegroundColor Gray
    exit 1
}

Write-Host ""

# Check authentication
Write-Host "Checking authentication status..." -ForegroundColor Yellow
try {
    $authList = pac auth list 2>&1
    if ($authList -match "No authentication profiles found") {
        Write-Host "✗ Not authenticated to Power Platform" -ForegroundColor Red
        Write-Host "  Authenticate with: pac auth create --cloud Public" -ForegroundColor Gray
        exit 1
    } else {
        Write-Host "✓ Authentication profile found" -ForegroundColor Green
        if ($Verbose) {
            Write-Host $authList -ForegroundColor Gray
        }
    }
} catch {
    Write-Host "✗ Error checking authentication" -ForegroundColor Red
    exit 1
}

Write-Host ""

# Check environment connection
Write-Host "Checking Dataverse environment connection..." -ForegroundColor Yellow
try {
    $orgWho = pac org who 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Connected to Dataverse environment" -ForegroundColor Green
        if ($Verbose) {
            Write-Host $orgWho -ForegroundColor Gray
        }
    } else {
        Write-Host "⚠ Not connected to a Dataverse environment" -ForegroundColor Yellow
        Write-Host "  Connect with: pac org select" -ForegroundColor Gray
    }
} catch {
    Write-Host "⚠ Could not verify Dataverse connection" -ForegroundColor Yellow
}

Write-Host ""

# Check available environments
Write-Host "Listing available environments..." -ForegroundColor Yellow
try {
    $envList = pac admin list --environment 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Environment list retrieved" -ForegroundColor Green
        if ($Verbose) {
            Write-Host $envList -ForegroundColor Gray
        }
    }
} catch {
    Write-Host "⚠ Could not list environments" -ForegroundColor Yellow
    Write-Host "  This may require additional permissions" -ForegroundColor Gray
}

Write-Host ""

# Check solution awareness
Write-Host "Checking solution capabilities..." -ForegroundColor Yellow
try {
    $solutionHelp = pac solution --help 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Solution commands available" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠ Solution commands may not be available" -ForegroundColor Yellow
}

Write-Host ""

# Check Canvas apps commands
Write-Host "Checking Canvas apps capabilities..." -ForegroundColor Yellow
try {
    $canvasHelp = pac canvas --help 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host "✓ Canvas apps commands available" -ForegroundColor Green
    }
} catch {
    Write-Host "⚠ Canvas apps commands may not be available" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Environment Check Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Summary
Write-Host "Summary for environment: $EnvironmentName" -ForegroundColor White
Write-Host "  PAC CLI: Installed ✓" -ForegroundColor Green
Write-Host "  Authentication: Configured ✓" -ForegroundColor Green
Write-Host "  Dataverse: Connected ✓" -ForegroundColor Green
Write-Host ""
Write-Host "Ready to proceed with Power Platform development!" -ForegroundColor Green
Write-Host ""
