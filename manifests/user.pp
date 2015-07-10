class influxdb::user (
  $user        = $::influxdb::user,
  $group       = $::influxdb::group,
  $manage_user = $::influxdb::manage_user
){

  if $manage_user {
    @user { $user:
      ensure  => $ensure,
      comment => 'InfluxDB service account',
      shell   => '/bin/false',
      gid     => $group
    }
    @group { $group:
      ensure  => $ensure
    }
  }

  Group<| title == $group |> ->
  User<| title == $user |>

}
