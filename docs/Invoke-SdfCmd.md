---
external help file: AxSQLServerCe-help.xml
Module Name: AxSQLServerCe
online version:
schema: 2.0.0
---

# Invoke-SdfCmd

## SYNOPSIS
Executes a T-SQL command against a SQL Server CE file

## SYNTAX

```
Invoke-SdfCmd [-Query] <String> [<CommonParameters>]
```

## DESCRIPTION
Run a T-SQL query against a SQL SErver CE database (.sdf file)

## EXAMPLES

### Example 1
```powershell
PS C:\> Connect-SdfFile c:\Temp\MyDatabase.sdf
PS C:\> Invoke-SdfCmd -Query "SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'TABLE'"
```

Lists all tables in the MyDatabase SQL Server CE database

### Example 2
```powershell
PS C:\> Invoke-SdfCmd -Query "CREATE TABLE [MyTable] ([Id] int NOT NULL  IDENTITY (1,1), [Name] nvarchar(450) NOT NULL);"
PS C:\> Invoke-SdfCmd -Query "ALTER TABLE [Files] ADD CONSTRAINT [PK_Files] PRIMARY KEY ([Id]);"
PS C:\> Invoke-SdfCmd -Query "ALTER TABLE [MyTable] ADD CONSTRAINT [PK_MyTable] PRIMARY KEY ([Id]);"
PS C:\> Invoke-SdfCmd -Query "CREATE UNIQUE INDEX [IX_MyTable_Name] ON [MyTable] ([Name] ASC);"
```

Creates a new table in the databse currently bound by Connect-SdfFile

### Example 3
```powershell
PS C:\> Invoke-SdfCmd -Query "SELECT * from MyTable"
```

Retrieves all lines in MyTable

## PARAMETERS

### -Query
A T-SQL query to execute against your SQL Server CE Database

```yaml
Type: String
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
