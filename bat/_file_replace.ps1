using namespace System

Param(
    [string] $fileName,
    [string] $oldString,
    [string] $newString = ''
)

# Get-Content $fileName | foreach { $_ -replace $oldString, $newString }
Get-Content $fileName | foreach { $_.Replace($oldString, $newString) }
