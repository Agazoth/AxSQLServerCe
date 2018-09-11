---
external help file: AxSQLServerCE-help.xml
Module Name: AxSQLServerCE
online version:
schema: 2.0.0
---

# Connect-SdfFile

## SYNOPSIS

Connect to a SQL Server CE file.

## SYNTAX

```
Connect-SdfFile [-Path] <FileInfo> [-TimeOut <Int32>] [-MaxDBSize <Int32>] [<CommonParameters>]
```

## DESCRIPTION

Creates a connection to a SQL Server CE file (.sdf file). Use this cmdlet prior to running InvokeSdfCmd

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-SdfFile -Path C:\Temp\MyDatabase.sdf
```

Establishes a connection to MyDatabase. The connection persists until the console is closed or a new connection is established.

## PARAMETERS

### -Path

A valid SQL Server CE file (.sdf file)

```yaml
Type: FileInfo
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -MaxDBSize
Max database size can be set. Initial value is set to 4091 which is max size

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -TimeOut
Timeout can be set. Set to 10 default

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
