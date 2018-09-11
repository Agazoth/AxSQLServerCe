---
external help file: AxSQLServerCE-help.xml
Module Name: AxSQLServerCE
online version:
schema: 2.0.0
---

# New-SdfFile

## SYNOPSIS

Create a new SQL Server CE Database

## SYNTAX

```
New-SdfFile [-Path] <FileInfo> [-Force] [-Connect] [<CommonParameters>]
```

## DESCRIPTION

Creates a new SQL Server CE database file in the supplied location.

## EXAMPLES

### Example 1

```powershell
PS C:\> New-SdfFile -Path C:\Temp\MyDatabase.sdf
```

Creates a new SQL Server CE file in C:\Temp called MyDatabase.sdf. Use Connect-SdfFile fo

## PARAMETERS

### -Connect

Connects to the database just created

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

Overwrites the SQL Server CE file, if it exists

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Path to the sdf-file

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
