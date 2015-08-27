class influxdb::package (
  $ensure                  = $::influxdb::ensure,
  $install_from_repository = $::influxdb::install_from_repository,
  $install_rc              = $::influxdb::install_rc,
  $install_nightly         = $::influxdb::install_nightly,
  $install_source          = $::influxdb::install_source,
  $version                 = $::influxdb::version
) {

  package { 'influxdb':
  }

  if $install_from_repository {

    Package['influxdb'] {
      ensure => $ensure
    }

  } else {

    case $::osfamily {
      'Debian': {
        $package_provider = 'dpkg'
      }
      'RedHat', 'Amazon': {
        $package_provider = 'rpm'
      }
      default: {
        fail("Only supports Debian or RedHat ${::osfamily}")
      }
    }

    $package_source = $install_source ? {
      undef   => influxdb_download_url($install_rc, $install_nightly, $version),
      default => $install_source
    }

    Package['influxdb'] {
      ensure   => $version,
      provider => $package_provider,
      source   => $package_source
    }

  }

}
