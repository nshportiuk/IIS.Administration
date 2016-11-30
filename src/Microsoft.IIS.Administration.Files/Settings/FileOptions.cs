﻿// Copyright (c) Microsoft Corporation. All rights reserved.
// Licensed under the MIT license. See LICENSE file in the project root for full license information.


namespace Microsoft.IIS.Administration.Files
{
    using Extensions.Configuration;
    using System.Collections.Generic;
    using System.Linq;

    public class FileOptions
    {
        private FileOptions() { }

        public List<AllowedRoot> Allowed_Roots { get; set; }

        public static FileOptions EmptyOptions()
        {
            return new FileOptions() {
                Allowed_Roots = new List<AllowedRoot>()
            };
        }

        public static FileOptions FromConfiguration(IConfiguration configuration)
        {
            FileOptions options = null;

            if (configuration.GetSection("files").GetChildren().Count() > 0) {
                options = EmptyOptions();
                ConfigurationBinder.Bind(configuration.GetSection("files"), options);
            }

            return options ?? DefaultOptions();
        }

        public static FileOptions DefaultOptions()
        {
            var options = EmptyOptions();

            options.Allowed_Roots.Add(new AllowedRoot() {
                Path = @"%SystemDrive%\inetpub",
                Read_Only = false
            });

            return options;
        }
    }
}