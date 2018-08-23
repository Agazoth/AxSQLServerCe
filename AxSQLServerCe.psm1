if(-not $PSScriptRoot)
{
    $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}

$Public  = Get-ChildItem $PSScriptRoot\*.ps1 -ErrorAction SilentlyContinue

 Foreach($import in @($Public))
{
    Try
    {
        #PS2 compatibility
        if($import.fullname)
        {
            . $import.fullname
        }
    }
    Catch
    {
        Write-Error "Failed to import function $($import.fullname): $_"
    }
}
$Binaries = Get-ChildItem "$PSScriptRoot\bin\" -Filter *dll
$DllImports = Foreach ($Binary in $binaries) {
    Import-Module $Binary.fullname -PassThru | Select-Object -ExpandProperty ExportedCommands
    }
$ModuleMembers = $DllImports.Keys
$Functions = $($Public | Select-Object -ExpandProperty BaseName)
Export-ModuleMember -Function $Functions -Cmdlet $ModuleMembers