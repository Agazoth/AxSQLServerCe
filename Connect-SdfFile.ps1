function Connect-SdfFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]$Path
    )
    
    begin {
    }
    process {
        if ($Path.Exists) {
            $ConnStr = "Data Source='{0}'" -f $Path.FullName
            $script:SdfConnection = New-Object "System.Data.SqlServerCe.SqlCeConnection" $ConnStr
            $script:SdfCommand = New-Object "System.Data.SqlServerCe.SqlCeCommand"
            $script:SdfCommand.CommandType = [System.Data.CommandType]"Text"
            $script:SdfCommand.Connection = $script:SdfConnection
        }
        else {
            Write-Warning "$($Path.FullName) not found"
        }
    }
    end {
    }
}