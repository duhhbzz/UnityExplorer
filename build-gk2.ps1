param(
    [string]$GameDir = "$([Environment]::GetFolderPath('ProgramFilesX86'))\Steam\steamapps\common\Graveyard Keeper 2",
    [ValidateSet("Debug", "Release")]
    [string]$Configuration = "Release"
)

$ErrorActionPreference = "Stop"

$managedDir = Join-Path $GameDir "GraveyardKeeper2_Data\Managed"
$netstandard = Join-Path $managedDir "netstandard.dll"
$systemRuntime = Join-Path $managedDir "System.Runtime.dll"

if (-not (Test-Path $netstandard)) {
    throw "Could not find GK2 netstandard.dll at '$netstandard'. Pass -GameDir with your Graveyard Keeper 2 install path."
}

if (-not (Test-Path $systemRuntime)) {
    throw "Could not find GK2 System.Runtime.dll at '$systemRuntime'. Pass -GameDir with your Graveyard Keeper 2 install path."
}

Push-Location $PSScriptRoot
try {
    git submodule sync --recursive
    if ($LASTEXITCODE -ne 0) {
        throw "git submodule sync failed."
    }

    git submodule update --init --recursive
    if ($LASTEXITCODE -ne 0) {
        throw "git submodule update failed."
    }

    $project = Join-Path $PSScriptRoot "UnityExplorer.BepInEx5.MonoBleedingEdge\UnityExplorer.BepInEx5.MonoBleedingEdge.csproj"

    dotnet build $project -c $Configuration "-p:GK2ManagedDir=$managedDir"
    if ($LASTEXITCODE -ne 0) {
        throw "UnityExplorer GK2 build failed."
    }

    $output = Join-Path $PSScriptRoot "bin\$Configuration\UnityExplorer.BepInEx5.MonoBleedingEdge\plugins\sinai-dev-UnityExplorer"

    Write-Host ""
    Write-Host "GK2 UnityExplorer build complete."
    Write-Host "Plugin folder:"
    Write-Host "  $output"
}
finally {
    Pop-Location
}
