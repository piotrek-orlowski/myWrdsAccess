# Introduction

This is a package for [WRDS](https://wrds-web.wharton.upenn.edu/wrds/index.cfm) users. Its only purpose is to create an odbc connection based on a Data Source configured in your operating system.

# Setup

The package was only tested in Windows. It requires that you set up a Data Source in the ODBC Data Sources manager, and set it up as follows:

Data source name: wrds-postgres

- Driver           = PostgreSQL
- Description      = Connect to WRDS on the WRDS Cloud
- Database         = wrds
- Username         = wrds_username
- Password         = wrds_password
- Servername       = wrds-pgdata-h.wharton.private
- Port             = 9737
- SSLmode          = require

It also requires you install a PostgreSQL driver.

# Usage

Once everything runs, just type
```
wrds_connect()
```
and an ODBC connection named `wrds` will be created in your `.GlobalEnv` (or within the environment of the function you're writing).

The package also contains some utilities for querying WRDS for table and column names.
