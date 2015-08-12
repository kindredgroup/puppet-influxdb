class influxdb::package (
  $ensure                  = $::influxdb::ensure,
  $install_from_repository = $::influxdb::install_from_repository,
  $install_rc              = $::influxdb::install_rc,
  $install_nightly         = $::influxdb::install_nightly,
  $version                 = $::influxdb::version
) {

  package { 'influxdb':
    ensure => $ensure
  }

  if !$install_from_repository {
    case $::osfamily {
      'Debian': {
        $package_provider = 'dpkg'
        $package_source = influxdb_download_url($install_rc, $install_nightly)
      }
      'RedHat', 'Amazon': {
        $package_provider = 'rpm'
        $package_source = influxdb_download_url($install_rc, $install_nightly)
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
