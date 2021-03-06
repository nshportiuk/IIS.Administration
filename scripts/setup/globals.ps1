﻿# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for full license information.


Param (
    [parameter(Mandatory=$true , Position=0)]
    [ValidateSet("ONECORE",
                 "DEFAULT_ADMIN_ROOT_NAME",
                 "DEFAULT_INSTALL_PATH",
                 "IIS_HWC_APP_ID",
                 "INSTALL_METHOD_KEY",
                 "INSTALL_METHOD_VALUE",
                 "DEFAULT_SERVICE_NAME",
                 "SERVICE_DESCRIPTION",
                 "CERT_NAME",
                 "IISAdministratorsGroupName",
                 "IISAdministratorsDescription")]
    [string]
    $Command
)

$INSTALL_METHOD_KEY = "IIS_ADMIN_INSTALL_METHOD"

switch ($Command)
{
    "ONECORE"
    {
        return [System.Environment]::OSVersion.Version.Major -ge 10
    }
    # Application directory name
    "DEFAULT_ADMIN_ROOT_NAME"
    {
        return "IIS Administration"
    }
    "DEFAULT_INSTALL_PATH"
    {
        return Join-Path $env:ProgramFiles $(.\globals.ps1 DEFAULT_ADMIN_ROOT_NAME)
    }
    # Application id for IIS Hostable Web Core
    "IIS_HWC_APP_ID"
    {
        return "{4dc3e181-e14b-4a21-b022-59fc669b0914}"
    }
    # Key for retrieving the installation strategy used
    "INSTALL_METHOD_KEY"
    {
        return $INSTALL_METHOD_KEY
    }
    # Value of installation strategy
    "INSTALL_METHOD_VALUE"
    {
        $installMethod = Get-Variable -Name $INSTALL_METHOD_KEY -ErrorAction SilentlyContinue
        if ($installMethod -ne $null) {
            $installMethod = $installMethod.Value
        }
        return $installMethod
    }
    # Application service name
    "DEFAULT_SERVICE_NAME"
    {
        return "Microsoft IIS Administration"
    }
    "SERVICE_DESCRIPTION"
    {
        return "Management service for IIS."
    }
    "CERT_NAME"
    {
        return "Microsoft IIS Administration Server Certificate"
    }
    # Application administrators group
    "IISAdministratorsGroupName"
    {
        return "IIS Administrators"
    }
    "IISAdministratorsDescription"
    {
        return "Members of this group have complete and unrestricted access to all features of IIS."
    }
    default
    {
        throw "Unknown command"
    }
}