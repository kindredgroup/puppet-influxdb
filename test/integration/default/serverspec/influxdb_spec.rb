require 'serverspec'

set :backend, :exec

describe service('influxdb') do
  it { should be_enabled }
  it { should be_running }
end

['8083', '8086'].each do |portnum|
  describe port(portnum) do
    it { should be_listening }
  end
end
