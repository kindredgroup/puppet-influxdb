# influxdb

#### Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with influxdb](#setup)
    * [Beginning with influxdb](#beginning-with-influxdb)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

## Overview

Puppet module that installs and configures InfluxDB, a time series metrics data base
written in Go. The module supports InfluxDB 0.9 and has been tested on EL6

## Module Description

The module installs InfluxDB, manages its configuration and the daemon process
lifecycle.

## Setup

### Beginning with influxdb

See metadata.json for dependencies

## Usage

In its simplest form using defaults:

```
include ::influxdb
```

This will create the influxdb service account, install the package
from the official repository, manage the configuration and init script source
file and start the service.

The module supports a number of class parameters to customize the behavior of
InfluxDB, refer to the documentation in init.pp

## Limitations

Only tested on EL6

## Development

### Unit tests

```
bundle exec rake spec
```

### Acceptance tests

```
bundle exec kitchen test
```
