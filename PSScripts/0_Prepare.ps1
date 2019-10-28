. (join-path $PSScriptRoot "./.Settings.ps1")

$ModuleToolAPIPath = "C:\_Source\Community\Waldo.Model.Tools\The Magic\NavModelToolsAPI.dll"
import-module $ModuleToolAPIPath -WarningAction SilentlyContinue -Verbose
