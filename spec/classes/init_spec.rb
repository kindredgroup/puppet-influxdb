require 'spec_helper'

describe 'influxdb' do

  context 'with defaults for all parameters' do
    it { should compile.with_all_deps }
    it { should contain_class('influxdb') }
    it { should contain_user('influxdb') }
    it { should contain_group('influxdb') }
    it { should contain_package('influxdb') }
    it { should contain_service('influxdb') }
    it { should contain_file('/etc/default/influxdb').with_content(/USER=influxdb\nGROUP=influxdb\nSTDERR=/) }
    it { should contain_file('/etc/opt/influxdb/influxdb.conf').with_content(/\[retention\]\n  check-interval = \"10m\"\n  enabled = true\n/) }
    it { should contain_class('influxdb::package').that_notifies('Class[influxdb::service]') }
    it { should contain_class('influxdb::config').that_notifies('Class[influxdb::service]') }
  end

  context 'with any configuration setting (config_retention here) custom setting' do
    let :params do {
      :config_retention => {
        'foo'    => 'bar',
        'number' => 10
      }
    } end

    it { should contain_file('/etc/opt/influxdb/influxdb.conf').with_content(/\n\[retention\]\n  foo = \"bar\"\n  number = 10\n\n/)}
  end

  context 'with service_refresh => false' do
    let :params do {
      :service_refresh => false
    } end

    it { should compile.with_all_deps }
    it { should_not contain_class('influxdb::package').that_notifies('Class[influxdb::service]') }
    it { should_not contain_class('influxdb::config').that_notifies('Class[influxdb::service]') }
  end

  context 'with any configuration setting disabled' do
    let :params do {
      :config_retention => false
    } end

    it { should_not contain_file('/etc/opt/influxdb/influxdb.conf').with_content(/\n\[retention\]\n/) }
  end

end
