include ::influxdb

::influxdb::management::database { 'testdb':
  ensure => present
}

::influxdb::management::database { 'testdb2':
  ensure => absent
}
