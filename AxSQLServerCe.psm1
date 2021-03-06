function Connect-SdfFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]$Path,
        [int]$TimeOut = 10,
        [int]$MaxDBSize = 4091,
        [string]$UnsecurePassword,
        [switch]$SecurePassword
    )
    
    begin {
        if ($SecurePassword){
            $Password = Read-Host "Type your password" -AsSecureString
            $UnsecurePassword = (New-Object PSCredential "user",$Password).GetNetworkCredential().Password
        }

    }
    process {
        if ($Path.Exists) {
            $ConnStr = "Data Source='{0}';File Access Retry Timeout={1};Max Database Size={2}" -f $Path.FullName, $TimeOut, $MaxDBSize
            if ($Password){$ConnStr += ";Password=$UnsecurePassword"}
            $script:SdfConnection = New-Object "System.Data.SqlServerCe.SqlCeConnection" $ConnStr
            $script:SdfCommand = New-Object "System.Data.SqlServerCe.SqlCeCommand"
            $script:SdfCommand.CommandType = [System.Data.CommandType]"Text"
            $script:SdfCommand.Connection = $script:SdfConnection
            Write-Verbose "Connection to $script:SdfConnection has been established"
        }
        else {
            Write-Warning "$($Path.FullName) not found"
        }
    }
    end {
    }
}
$Script:Config = Import-Clixml $PSScriptRoot\config.clixml
$Script:Config.QueryRootPath = $Script:Config.QueryRootPath -f $PSScriptRoot
function Invoke-SdfCmd {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(ParameterSetName = "Typed",
            Position = 0,
            Mandatory = $true)]
        [String]$TQuery,
        [Parameter(ParameterSetName = "Saved",
            Position = 1,
            Mandatory = $false)]
        [string[]]$ReplaceVariables

    )

    DynamicParam {
        $ParameterName = 'Query'
        $QueryNames = foreach ($File in Get-ChildItem -Path $Script:Config.QueryRootPath -File -Filter *.sql -Recurse) {
            $BasePath = $File.Fullname -replace $($Config.QueryRootPath -replace '\\', '\\') -replace '\.sql$'
            $BasePath.trim('\')
        }
        $ParameterAttribute = New-Object System.Management.Automation.ParameterAttribute
        $ParameterAttribute.ParameterSetName="Saved"
        $ParameterAttribute.Mandatory = $true
        $ParameterAttribute.Position = 0
        $AttributeCollection = New-Object System.Collections.ObjectModel.Collection[System.Attribute]
        $AttributeCollection.Add($ParameterAttribute)
        $ValidateSetAttribute = New-Object System.Management.Automation.ValidateSetAttribute($QueryNames)
        $AttributeCollection.Add($ValidateSetAttribute)
        $RuntimeParameter = New-Object System.Management.Automation.RuntimeDefinedParameter($ParameterName, [string], $AttributeCollection)
        $RuntimeParameterDictionary = New-Object System.Management.Automation.RuntimeDefinedParameterDictionary
        $RuntimeParameterDictionary.Add($ParameterName, $RuntimeParameter)
        return $RuntimeParameterDictionary
    }
    
    begin {
        if (!$script:SdfConnection){
            throw 'No SDF connection found. Run Connect-SdfFile prior to running this command.'
        }
        $QueryString=''
        if ($PsCmdlet.ParameterSetName -eq "Saved"){
            Write-Verbose "Executing a saved query"
            $QueryPath = '{0}\{1}.sql' -f $Config.QueryRootPath, $PsBoundParameters[$ParameterName]
            if (test-path $QueryPath) {
                $QueryString = $(Get-Content $QueryPath -raw) -f $ReplaceVariables
            }
            else {
                Write-Warning "$QueryPath not found"
                continue
            }
        }
        if ($PsCmdlet.ParameterSetName -eq "Typed"){
            Write-Verbose "Executing a typed query"
            $QueryString = $TQuery
        }
        Write-Verbose "Executing: $QueryString"
        $script:SdfCommand.CommandText = $QueryString
        $script:SdfConnection.Open()
    }
    
    process {
        if ($QueryString -match 'SELECT'){
            Write-Verbose "Running a Reader query"
            $DataTable = new-object "System.Data.DataTable"
            $DataReader = $script:SdfCommand.ExecuteReader()
            $DataTable.Load($DataReader)
            $script:SdfConnection.Close()
            $DataTable
        }
        else {
            Write-Verbose "Running a NonQuery query"
            $NonQuery = $script:SdfCommand.ExecuteNonQuery()
            Write-Verbose $NonQuery
        }
    }

    end {
        try {$script:SdfConnection.Close()} catch {}
    }
}
function New-SdfFile {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true)]
        [System.IO.FileInfo]$Path,
        # Just a Switch
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
function Set-SavedQuery {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$QueryName,
        [Parameter(Mandatory = $true, Position = 1)]
        [string[]]$Query,
        [Parameter(Mandatory = $false, Position = 2)]
        [switch]$Force,
        [System.IO.DirectoryInfo]$UpdateQueryPath
    )
    
    begin {
        if ($UpdateQueryPath) {
            try {
                $Script:Config | Export-Clixml $PSScriptRoot\config.clixml
            }
            catch { 
                Write-Warning "You need write access to $PSScriptRoot in order to update the Saved Queries path"
                Continue
            }
            if (!$UpdateQueryPath.exists) {
                try {
                    $Null = New-Item -ItemType Directory -Path $UpdateQueryPath -Force -ErrorAction stop
                }
                Catch {
                    Write-Warning "Could not create $UpdateQueryPath"
                    continue
                }
            }
            else {
                Write-warning "You have chosen an existing path. Only sql-files in this directory will be available for this module"
            }
            foreach ($File in $(Get-ChildItem -Path $Script:Config.QueryRootPath -File *.sql -Recurse)) {
                $TargetPath = Split-path $($File.fullname -replace $($Script:Config.QueryRootPath -replace '\\','\\'),$UpdateQueryPath)
                if (!$(Test-PAth $TargetPath)){
                    $Null = New-Item -ItemType Directory -Path $TargetPath
                }
                Copy-Item $File.Fullname -Destination $TargetPath
            } 
            $Script:Config.QueryRootPath = $UpdateQueryPath
            $Script:Config | Export-Clixml $PSScriptRoot\config.clixml
            Write-Verbose "Query root path is now:  $($Script:Config.QueryRootPath)"
        }

        $FilePath = '{0}\{1}.sql' -f $Script:Config.QueryRootPath, $QueryName
        if ($(test-path $FilePath)) {
            if ($Force) {
                Write-Warning "Updating saved query: $QueryName"
            }
            else {
                Write-Warning "$QueryName exists. Use Force switch to overwrite"
                Continue
            }
        }
    }
    
    process {
        try {
            $Query | Out-File $FilePath -Force -ErrorAction Stop
        }
        catch {
            Write-warning "You do not have write permissions to $($Script:Config.QueryRootPath). Change the saved queries path using the -UpdateQueryPath switch or run the cmdlet elevated"
        }
        
    }
    
    end {
    }
}
