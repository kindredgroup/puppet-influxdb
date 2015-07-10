# == Class: influxdb
#
# Full description of class influxdb here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the function of this class and if
#   it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should be avoided in favor of class parameters as
#   of Puppet 2.6.)
#
# === Examples
#
#  class { 'influxdb':
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2015 Your name here, unless otherwise noted.
#
class influxdb (
  $ensure                    = present,
  $install_from_repository   = false,
  $version                   = $::influxdb::params::version,
  $user                      = $::influxdb::params::user,
  $group                     = $::influxdb::params::group,
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
