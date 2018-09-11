---
external help file: AxSQLServerCE-help.xml
Module Name: AxSQLServerCE
online version:
schema: 2.0.0
---

# Invoke-SdfCmd

## SYNOPSIS

Executes a T-SQL command against a SQL Server CE file

## SYNTAX

### Typed
```
Invoke-SdfCmd -TQuery <String> [<CommonParameters>]
```

### Saved
```
Invoke-SdfCmd [-ReplaceVariables <String[]>] -Query <String> [<CommonParameters>]
```

## DESCRIPTION

Run a T-SQL query against a SQL SErver CE database (.sdf file)

## EXAMPLES

### Example 1

```powershell
PS C:\> Connect-SdfFile c:\Temp\MyDatabase.sdf
PS C:\> Invoke-SdfCmd -TQuery "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'TABLE'"
```

Lists all tables in the MyDatabase SQL Server CE database

### Example 2

```powershell
PS C:\> Invoke-SdfCmd -TQuery "CREATE TABLE [MyTable] ([Id] int NOT NULL  IDENTITY (1,1), [Name] nvarchar(450) NOT NULL);"
PS C:\> Invoke-SdfCmd -TQuery "ALTER TABLE [MyTable] ADD CONSTRAINT [PK_MyTable] PRIMARY KEY ([Id]);"
PS C:\> Invoke-SdfCmd -TQuery "ALTER TABLE [MyTable] ADD CONSTRAINT [PK_MyTable] PRIMARY KEY ([Id]);"
PS C:\> Invoke-SdfCmd -TQuery "CREATE UNIQUE INDEX [IX_MyTable_Name] ON [MyTable] ([Name] ASC);"
```

Creates a new table in the databse currently bound by Connect-SdfFile

### Example 3

```powershell
PS C:\> Invoke-SdfCmd -TQuery "SELECT * from MyTable"
```

Retrieves all lines in MyTable

## PARAMETERS

### -TQuery

Any TSQL query that is allowed in SQL Server CE

```yaml
Type: String
Parameter Sets: Typed
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ReplaceVariables

A string collection for updating a saved query. Format string is used in the function, thus elements 0,1,2,3 ... are replaced with the equivalent {0}, {1}, {2} in the saved Query according to the string replace rules.

```yaml
Type: String[]
Parameter Sets: Saved
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Query

Saved TSQL queries. Autocomplete is enabled on saved Queries. Additional saved queries can be added by running Set-SavedQuery

```yaml
Type: String
Parameter Sets: Saved
Aliases:

Required: True
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
