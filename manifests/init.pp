# == Class: influxdb
#
# Entry point for installing and configuring influxdb
# https://influxdb.com
#
# === Parameters
#
# Document parameters here.
#
# [*ensure*]
#   Ensurable
#
# [*install_from_repository*]
#   If package should be installed from any configured OS package repository,
#   false will use the distribution provided by influxdb
#   Valid values: boolean
#
# [*install_rc*]
#   If not installing from repository, use latest RC provided by influxdb
#   Valid values: boolean
#
# [*install_nightly*]
#   If not installing from repository, use nightly build provided by influxdb
#   Valid values: boolean
#
# [*version*]
#   Version to install
#   Valid values: string version
#
# [*username*]
#   Name of service user
#   Valid values: string
#
# [*groupname*]
#   Name of service user group
#   Valid values: string
#
# [*manage_user*]
#   If user / group resource should be managed by the module
#   Valid values: boolean
#
# [*service_ensure*]
#   Service ensurable
#
# [*service_enable*]
#   Service enable parameter
#
# [*service_refresh*]
#   If changes in config and package should notify the service
#   Valid values: boolean
#
# [*config_toplevel*]
#   Configures the top level configuration settings in the influxdb
#   configuration file. Will not merge with the provided defaults.
#   Valid values: hash
#
# [*config_<rest_of_them>*]
#   Configures specific section in the influxdb configuration file
#   Defaults are used from params.pp if not set, the module will
#   not merge configuration if you set any of the parameters - you
#   will have to specify any of the defaults explicitly if you intend to
#   keep certain default behaviors.
#   Setting any of them to false
#
# === Examples
#
# include ::influxdb
#
# === Copyright
#
# Copyright 2015 North Development AB
#
class influxdb (
  $ensure                    = present,
  $install_from_repository   = false,
  $install_rc                = false,
  $install_nightly           = false,
  $version                   = $::influxdb::params::version,
  $username                  = $::influxdb::params::username,
  $groupname                 = $::influxdb::params::groupname,
  $manage_user               = true,
  $service_ensure            = running,
  $service_enable            = true,
  $service_refresh           = true,
  $logdirectory              = $::influxdb::params::logdirectory,
  $config_toplevel           = $::influxdb::params::config_toplevel,
  $config_meta               = $::influxdb::params::config_meta,
  $config_data               = $::influxdb::params::config_data,
  $config_cluster            = $::influxdb::params::config_cluster,
  $config_retention          = $::influxdb::params::config_retention,
  $config_admin              = $::influxdb::params::config_admin,
  $config_http               = $::influxdb::params::config_http,
  $config_graphite           = $::influxdb::params::config_graphite,
  $config_collectd           = $::influxdb::params::config_collectd,
  $config_opentsdb           = $::influxdb::params::config_opentsdb,
  $config_udp                = $::influxdb::params::config_udp,
  $config_monitoring         = $::influxdb::params::config_monitoring,
  $config_continuous_queries = $::influxdb::params::config_continuous_queries,
  $config_hinted_handoff     = $::influxdb::params::config_hinted_handoff
) inherits influxdb::params {

  anchor { '::influxdb::begin': } ->
  class { '::influxdb::user': } ->
  class { '::influxdb::package': } ->
  class { '::influxdb::files': } ->
  class { '::influxdb::config': } ->
  class { '::influxdb::service': } ->
  anchor { '::influxdb::end': }

  if $service_refresh {
    Class['::influxdb::package'] ~> Class['::influxdb::service']
    Class['::influxdb::config'] ~> Class['::influxdb::service']
  }

}
