function Invoke-SdfCmd {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$true)]
        [String]$Query
    )
    
    begin {
        if (!$script:SdfConnection){
            throw 'No SDF connection found. Run Connect-SdfFile prior to running this command.'
        }
        $script:SdfCommand.CommandText = $Query
        $script:SdfConnection.Open()
    }
    
    process {
        if ($Query -match 'SELECT'){
            $DataTable = new-object "System.Data.DataTable"
            $DataReader = $script:SdfCommand.ExecuteReader()
            $DataTable.Load($DataReader)
            $script:SdfConnection.Close()
            $DataTable
        }
        else {
            $NonQuery = $script:SdfCommand.ExecuteNonQuery()
            Write-Verbose $NonQuery
        }
    }

    end {
        try {$script:SdfConnection.Close()} catch {}
    }
}