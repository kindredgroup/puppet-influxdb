class influxdb::config (
  $ensure                    = $::influxdb::ensure,
  $username                  = $::influxdb::username,
  $groupname                 = $::influxdb::groupname,
  $logdirectory              = $::influxdb::logdirectory,
  $config_toplevel           = $::influxdb::config_toplevel,
  $config_meta               = $::influxdb::config_meta,
  $config_data               = $::influxdb::config_data,
  $config_cluster            = $::influxdb::config_cluster,
  $config_retention          = $::influxdb::config_retention,
  $config_admin              = $::influxdb::config_admin,
  $config_http               = $::influxdb::config_http,
  $config_graphite           = $::influxdb::config_graphite,
  $config_collectd           = $::influxdb::config_collectd,
  $config_opentsdb           = $::influxdb::config_opentsdb,
  $config_udp                = $::influxdb::config_udp,
  $config_monitoring         = $::influxdb::config_monitoring,
  $config_continuous_queries = $::influxdb::config_continuous_queries,
  $config_hinted_handoff     = $::influxdb::config_hinted_handoff
) {

  file { $::influxdb::params::default_file:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/default.erb")
  }

  file { $::influxdb::params::config:
    ensure  => $ensure,
    owner   => 'root',
    group   => 'root',
    mode    => '0644',
    content => template("${module_name}/influxdb.conf.erb")
  }

}
