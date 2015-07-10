class influxdb::user (
  $ensure      = $::influxdb::ensure,
  $username    = $::influxdb::username,
  $groupname   = $::influxdb::groupname,
  $manage_user = $::influxdb::manage_user
) {

  if $manage_user {
    @group { $groupname:
      ensure => $ensure
    }
    @user { $username:
      ensure  => $ensure,
      comment => 'InfluxDB service account',
      shell   => '/bin/bash',
      gid     => $groupname
    }
  }

  Group <| title == "$groupname" |> -> User <| title == "$username" |>

}
