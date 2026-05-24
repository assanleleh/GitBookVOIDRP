$ErrorActionPreference = "Stop"

$Root = Split-Path -Parent $PSScriptRoot
$McpDir = Join-Path $Root "tools\gitbook-mcp"
$Repo = "https://github.com/lucasbenevinuto/gitbook-mcp.git"

Write-Host "==> Configuration GitBook MCP"

if (-not (Test-Path $McpDir)) {
    Write-Host "    Clonage de gitbook-mcp..."
    New-Item -ItemType Directory -Force -Path (Split-Path $McpDir) | Out-Null
    git clone --depth 1 $Repo $McpDir
}

Write-Host "    Installation des dépendances..."
Push-Location $McpDir
try {
    npm install
    npm run build
} finally {
    Pop-Location
}

$EnvExample = Join-Path $Root ".env.example"
$EnvFile = Join-Path $Root ".env"
if (-not (Test-Path $EnvFile)) {
    Copy-Item $EnvExample $EnvFile
    Write-Host "    .env créé depuis .env.example — ajoutez votre token GitBook."
} else {
    Write-Host "    .env déjà présent."
}

Write-Host ""
Write-Host "Prochaines étapes :"
Write-Host "  1. Éditez .env avec votre GITBOOK_API_TOKEN"
Write-Host "  2. Redémarrez Cursor pour activer le serveur MCP gitbook"
Write-Host "  3. Connectez Git Sync dans GitBook (voir SETUP.md)"
