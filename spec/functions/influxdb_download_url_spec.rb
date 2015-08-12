require "spec_helper"
require 'webmock'
include WebMock::API

stub_request(:get, "https://s3.amazonaws.com/influxdb/?prefix=influxdb").
  with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
  to_return(:status => 200, :body => File.read('spec/data/mock_s3.xml'), :headers => {})

expected_package = {
  "RedHat" => {
    "x86_64" => {
      "nightly" => "influxdb-nightly-1.x86_64.rpm",
      "rc"      => "influxdb-0.9.2_rc1-1.x86_64.rpm",
      "release" => "influxdb-0.9.2.1-1.x86_64.rpm"
    },
    "i686"  => {
      "nightly" => "influxdb-0.8.8-1.i686.rpm",
      "rc"      => "influxdb-0.8.8-1.i686.rpm",
      "release" => "influxdb-0.8.8-1.i686.rpm"
    }
  },
  "Debian" => {
    "x86_64" => {
      "nightly" => "influxdb_nightly_amd64.deb",
      "rc"      => "influxdb_0.9.2.1_amd64.deb",
      "release" => "influxdb_0.9.2.1_amd64.deb"
    },
    "i686" => {
      "nightly" => "influxdb_0.8.8_i686.deb",
      "rc"      => "influxdb_0.8.8_i686.deb",
      "release" => "influxdb_0.8.8_i686.deb"
    }
  }
}

describe "influxdb_download_url" do

  ['RedHat', 'Debian'].each do |distro|
    ['x86_64', 'i686'].each do |arch|
      describe "on #{distro} #{arch}" do
        let(:facts) do {
          :osfamily      => distro,
          :hardwaremodel => arch
        } end

        it {
          should run.with_params(false, false).and_return("https://s3.amazonaws.com/influxdb/#{expected_package[distro][arch]["release"]}")
        }

        it {
          should run.with_params(true, false).and_return("https://s3.amazonaws.com/influxdb/#{expected_package[distro][arch]["rc"]}")
        }

        it {
          should run.with_params(false, true).and_return("https://s3.amazonaws.com/influxdb/#{expected_package[distro][arch]["nightly"]}")
        }
      end
    end
  end

end
