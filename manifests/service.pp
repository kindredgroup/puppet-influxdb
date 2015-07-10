class influxdb::service (
  $ensure = $::influxdb::service_ensure,
  $enable = $::influxdb::service_enable
) {

  service { 'influxdb':
    ensure => $ensure,
    enable => $enable,
  }

}
