class influxdb::package (
  $ensure                  = $::influxdb::ensure,
  $install_from_repository = $::influxdb::install_from_repository,
  $version                 = $::influxdb::version
) {

  package { 'influxdb':
    ensure => $ensure
  }

  if !$install_from_repository {
    case $::osfamily {
      'Debian': {
        $package_provider = 'dpkg'
        $package_source = $::architecture ? {
          /64/    => "http://s3.amazonaws.com/influxdb/influxdb_${version}_amd64.deb",
          default => "http://s3.amazonaws.com/influxdb/influxdb_${version}_i386.deb",
        }
      }
      'RedHat', 'Amazon': {
        $package_provider = 'rpm'
        $package_source = $::architecture ? {
          /64/    => "http://s3.amazonaws.com/influxdb/influxdb-${version}-1.x86_64.rpm",
          default => "http://s3.amazonaws.com/influxdb/influxdb-${version}-1.i686.rpm",
        }
      }
      default: {
        fail("Only supports Debian or RedHat ${::osfamily}")
      }
    }

    Package['influxdb']{
      provider => $package_provider,
      source   => $package_source,
    }
  }

}
