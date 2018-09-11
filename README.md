# AxSQLServerCe Module

This module enables creating, editing and reading SQL Server CE files.

## Install AxSQLServerCe Module

The module is on the Powershell Gallery and can be installed by running

```Powershell
PS C:\> Install-Module AxSQLServerCe -Scope CurrentUser
```

## Usage instructions

See the integrated help

```Powershell
PS C:\> help Connect-SdfFile
```

## Description

This module is used for creating and using SQL Server CE databases. It facilitates interaction with the sdf file without the need for installing any other tools apart from this module. Often used queries can be saved in different categories and reused. Variables are supported in saved queries.

## AxSQLServerCe Cmdlets

### [Connect-SdfFile](docs/Connect-SdfFile.md)

Connect to a SQL Server CE file.

### [Invoke-SdfCmd](docs/Invoke-SdfCmd.md)

Executes a T-SQL command against a SQL Server CE file

### [New-SdfFile](docs/New-SdfFile.md)

Create a new SQL Server CE Database

### [Set-SavedQuery](docs/Set-SavedQuery.md)

Adds a saved TSQL query to the module. If this module is installed in a global module path, it requires administrator privileges to update queries or the saved queries path. If the module is installed in the current users module path, current access rights suffice.