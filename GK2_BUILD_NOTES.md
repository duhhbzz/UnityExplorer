# Graveyard Keeper 2 development build

This branch is wired for the Unity 6.3 compatibility changes in
`duhhbzz/UniverseLib`.

## Target

- Graveyard Keeper 2
- Unity 6.3 / Unity 6000-series scene-handle compatibility
- Mono
- BepInEx 5
- UnityExplorer **MonoBleedingEdge** project

The UnityExplorer submodule `external/UniverseLib` is pinned to the
GK2 review branch in `duhhbzz/UniverseLib`.

## Build

Clone this branch with submodules, or let the helper initialize them:

```powershell
git clone --branch dev/gk2-unity63 --recurse-submodules https://github.com/duhhbzz/UnityExplorer.git
cd UnityExplorer
.\build-gk2.ps1
```

The helper defaults to the standard Steam location:

`C:\Program Files (x86)\Steam\steamapps\common\Graveyard Keeper 2`

For a different location:

```powershell
.\build-gk2.ps1 -GameDir "D:\SteamLibrary\steamapps\common\Graveyard Keeper 2"
```

The build uses:

```text
UnityExplorer.BepInEx5.MonoBleedingEdge
```

and passes GK2's managed-assembly directory into UniverseLib through the
`GK2ManagedDir` MSBuild property.

Expected plugin output:

```text
bin\Release\UnityExplorer.BepInEx5.MonoBleedingEdge\plugins\sinai-dev-UnityExplorer
```

Copy that **sinai-dev-UnityExplorer** folder into GK2's
`BepInEx\plugins\` directory for development testing.

## Purpose

This is developer tooling only. GK2+ should not take a runtime dependency
on UnityExplorer or UniverseLib.

The immediate use case is live inspection of native GK2 UI:

- GameObject / RectTransform hierarchy
- Image and Sprite names
- Materials and textures
- colors/tints
- component ownership
- runtime fields/properties
- exporting textures for inspection
- C# console scripts for structured dumps
