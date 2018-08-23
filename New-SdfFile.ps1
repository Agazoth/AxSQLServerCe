function New-SdfFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]$Path,
        [switch]$Force,
        [switch]$Connect
    )
    
    begin {
        if ($Path.Exists){
            if ($Force){
                Remove-Item -Path $Path.FullName
            } else {
                throw "$($Path.FullName) exists. Use the Force switch to overwrite."
            }
        }
    }
    
    process {
        $ConnStr = "Data Source='{0}'" -f $Path.FullName
        $db = New-Object "System.Data.SqlServerCe.SqlCeEngine" $ConnStr
        $db.CreateDatabase()
        $db.Dispose()
        $Path.Refresh()
        if ($Path.Exists){
            Write-Verbose "$($Path.Fullname) has been created"
            if ($Connect){
                Connect-SdfFile -Path $Path.Fullname
            }
        }
        Else {
            Write-Warning "Could not create $($Path.Fullname)"
        }
    }
    
    end {
    }
}