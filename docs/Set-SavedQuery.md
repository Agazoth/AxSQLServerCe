---
external help file: AxSQLServerCE-help.xml
Module Name: AxSQLServerCE
online version:
schema: 2.0.0
---

# Set-SavedQuery

## SYNOPSIS

Adds a saved TSQL query to the module. If this module is installed in a global module path, it requires administrator privileges to update queries or the saved queries path. If the module is installed in the current users module path, current access rights suffice.

## SYNTAX

```
Set-SavedQuery -QueryName <String> [-Query] <String[]> [-Force] [-UpdateQueryPath <DirectoryInfo>]
 [<CommonParameters>]
```

## DESCRIPTION

Adds a saved TSQL query to the module. Use '\' to separate to different subfolders

## EXAMPLES

### Example 1

```powershell
PS C:\> Set-SavedQuery -QueryName "GetAllLinesFromMyTable" -Query "Select * from MyTable"
```

This command saves the query "Select * from MyTable" in your module and can be retrieved in the Invoke-SdfCmd inidiately

### Example 2

```powershell
PS C:\> Set-SavedQuery -UpdateQueryPath C:\Temp\SQL
```

This command updates the path for saved queries to C:\Temp\SQL. If there are subfolders with queries, they are moved to the same subfolders in the target directory.

## PARAMETERS

### -Query

The query string to save. A string array with complex TSQL queries can be added.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Force

If set, Force overwrites existing saved queries

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

### -QueryName

The Name of your query.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -UpdateQueryPath

Changes the path of saved SQL queries. When changed, existing uery files are copied to the new location.

```yaml
Type: DirectoryInfo
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
