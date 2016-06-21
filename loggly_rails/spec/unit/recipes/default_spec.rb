#
# Cookbook Name:: hola-mundo
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

describe 'loggly_rails::default' do
  context 'When all attributes are default, on an unspecified platform' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'creates rails syslog file' do
      expect(chef_run).to render_file('/etc/rsyslog.d/21-rails.conf')
    end

    it 'creates loggly syslog file' do
      expect(chef_run).to render_file('/etc/rsyslog.d/22-loggly.conf')
    end

    it 'restarts rsyslog service' do
      expect(chef_run.template('/etc/rsyslog.d/21-rails.conf')).
        to notify('service[rsyslog]').to(:restart)
      expect(chef_run.template('/etc/rsyslog.d/22-loggly.conf')).
        to notify('service[rsyslog]').to(:restart)
    end

    # it 'configures rsyslog with $MaxMessageSize' do
    #   expect(chef_run).to
    # end
  end
end
