class influxdb::params {

  $version = '0.9.1'
  $username = 'influxdb'
  $groupname = 'influxdb'
  $config = '/etc/opt/influxdb/influxdb.conf'
  $default_file = '/etc/default/influxdb'
  $logdirectory = '/var/log/influxdb'

  # default configuration
  $config_toplevel = {
    'reporting-disabled'  => true
  }

  $config_meta = {
    'dir'                   => '/var/opt/influxdb/meta',
    'hostname'              => 'localhost',
    'bind-address'          => ':8088',
    'retention-autocreate'  => true,
    'election-timeout'      => '1s',
    'heartbeat-timeout'     => '1s',
    'leader-lease-timeout'  => '500ms',
    'commit-timeout'        => '50ms'
  }

  $config_data = {
    'dir'                     => '/var/opt/influxdb/data',
    'MaxWALSize'              => 104857600,
    'WALFlushInterval'        => '10m',
    'WALPartitionFlushDelay'  => '2s'
  }

  $config_cluster = {
    'shard-writer-timeout' => '5s'
  }

  $config_retention = {
    'enabled'        => true,
    'check-interval' => '10m'
  }

  $config_admin = {
    'enabled'      => true,
    'bind-address' => ':8083'
  }

  $config_http = {
    'enabled'       => true,
    'bind-address'  => ':8086',
    'auth-enabled'  => false,
    'log-enabled'   => true,
    'write-tracing' => false,
    'pprof-enabled' => false
  }

  $config_graphite = {
    'enabled'           => false,
    'bind-address'      => ':2003',
    'protocol'          => 'tcp',
    'consistency-level' => 'one',
    'name-separator'    => '.'
  }

  $config_collectd = {
    'enabled' =>  false
  }

  $config_opentsdb = {
    'enabled' => false
  }

  $config_udp = {
    'enabled' => false
  }

  $config_monitoring = {
    'enabled'        => true,
    'write-interval' => '24h'
  }

  $config_continuous_queries = {
    'enabled'                   =>  true,
    'recompute-previous-n'      => 2,
    'recompute-no-older-than'   => '10m',
    'compute-runs-per-interval' => 10,
    'compute-no-more-than'      => '2m'
  }

  $config_hinted_handoff = {
    'enabled'          => true,
    'dir'              => '/var/opt/influxdb/hh',
    'max-size'         => 1073741824,
    'max-age'          => '168h',
    'retry-rate-limit' => 0,
    'retry-interval'   => '1s'
  }

}
