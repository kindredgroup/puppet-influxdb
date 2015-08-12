# == Define: influxdb::management::database
#
# Creates or drops an InfluxDB database
#
# === Parameters:
#
# [*namevar*]
#   Name of database to manage
#
# [*ensure*]
#   Ensurable, present - creates, absent - drops
#
define influxdb::management::database ( $ensure = 'present' ) {

    $db_name = $name

    validate_re($db_name, '^[a-zA-Z0-9]+$')

    case $ensure {
      present: {
        $command = "influx -execute 'CREATE DATABASE ${db_name}'"
        $unless = "influx -execute 'SHOW DATABASES' | grep -qs \"^${db_name}\$\""
        $onlyif = undef
      }
      absent: {
        $command = "influx -execute 'DROP DATABASE ${db_name}'"
        $unless = undef
        $onlyif = "influx -execute 'SHOW DATABASES' | grep -qs \"^${db_name}\$\""
      }
      default: {
        fail("Unsupported :ensure value ${ensure}")
      }
    }

    exec { "manage_influxdb_${db_name}":
      path    => '/bin:/usr/bin:/opt/influxdb',
      command => $command,
      unless  => $unless,
      onlyif  => $onlyif,
      require => Class['::influxdb::service']
    }

}
