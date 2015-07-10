require 'spec_helper'
describe 'influxdb' do

  context 'with defaults for all parameters' do
    it { should contain_class('influxdb') }
    it { should contain_user('influxdb') }
    it { should contain_group('influxdb') }
    it { should contain_package('influxdb') }
    it { should contain_service('influxdb') }
    it { should contain_file('/etc/default/influxdb').with_content(/USER=influxdb\nGROUP=influxdb\nSTDERR=/) }
    it { should contain_file('/etc/opt/influxdb/influxdb.conf').with_content(/\[retention\]\n  check-interval = \"10m\"\n  enabled = true\n/) }
  end

  context 'with custom settings' do
    let :params do {
      :config_retention => {
        'foo'    => 'bar',
        'number' => 10
      }
    } end

    it { should contain_file('/etc/opt/influxdb/influxdb.conf').with_content(/\[retention\]\n  foo = \"bar\"\n  number = 10\n/)}
  end

end
