---
external help file: AxSQLServerCe-help.xml
Module Name: AxSQLServerCe
online version:
schema: 2.0.0
---

# Connect-SdfFile

## SYNOPSIS
Connect to a SQL Server CE file.

## SYNTAX

```
Connect-SdfFile [-Path] <FileInfo> [<CommonParameters>]
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see about_CommonParameters (http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
