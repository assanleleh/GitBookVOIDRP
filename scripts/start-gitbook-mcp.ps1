$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$McpDir = Join-Path $Root "tools\gitbook-mcp"
$EnvFile = Join-Path $Root ".env"

if (Test-Path $EnvFile) {
    Get-Content $EnvFile | ForEach-Object {
        if ($_ -match '^\s*([^#=]+)=(.*)$') {
            $name = $matches[1].Trim()
            $value = $matches[2].Trim().Trim('"').Trim("'")
            if ($name -and $value) {
                Set-Item -Path "env:$name" -Value $value
            }
        }
    }
}

if (-not $env:GITBOOK_API_TOKEN -or $env:GITBOOK_API_TOKEN -eq "gb_api_REMPLACEZ_MOI") {
    Write-Error "GITBOOK_API_TOKEN manquant. Copiez .env.example vers .env et ajoutez votre token GitBook."
    exit 1
}

$Entry = Join-Path $McpDir "dist\index.js"
if (-not (Test-Path $Entry)) {
    Write-Error "gitbook-mcp non compilé. Exécutez scripts/setup.ps1 d'abord."
    exit 1
}

node $Entry
