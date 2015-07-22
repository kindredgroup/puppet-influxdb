class influxdb::files {

  $ensure = $::influxdb::ensure ? {
    present => directory,
    default => $::influxdb::ensure
  }

  file { $::influxdb::logdirectory:
    ensure => $ensure,
    owner  => $::influxdb::user,
    group  => $::influxdb::group,
    mode   => '0755',
  }

}
