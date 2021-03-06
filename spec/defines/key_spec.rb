# frozen_string_literal: true

require 'spec_helper'

describe 'dns::key' do
  let(:title) { 'rspec-key' }
  let(:params) do
    {}
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_file('/tmp/rspec-key-secret.sh').with_notify('Exec[dnssec-keygen-rspec-key]') }
      it { is_expected.to contain_exec('dnssec-keygen-rspec-key').with_command(%r{USER rspec-key$}) }
      it { is_expected.to contain_exec('get-secret-from-rspec-key').with_command('/tmp/rspec-key-secret.sh') }
      it { is_expected.to contain_exec('get-secret-from-rspec-key').with_creates('/etc/named/bind.keys.d/rspec-key.secret') }
      it { is_expected.to contain_exec('get-secret-from-rspec-key').with_require(['Exec[dnssec-keygen-rspec-key]', 'File[/etc/named/bind.keys.d]', 'File[/tmp/rspec-key-secret.sh]']) }
      it { is_expected.to contain_file('/etc/named/bind.keys.d/rspec-key.secret').with_require('Exec[get-secret-from-rspec-key]') }
      it { is_expected.to contain_concat('/etc/named/bind.keys.d/rspec-key.key') }
      ['rspec-key.key-header', 'rspec-key.key-secret', 'rspec-key.key-footer'].each do |fragment|
        it { is_expected.to contain_concat__fragment(fragment).with_target('/etc/named/bind.keys.d/rspec-key.key') }
        it { is_expected.to contain_concat__fragment(fragment).with_require(['Exec[get-secret-from-rspec-key]', 'File[/etc/named/bind.keys.d/rspec-key.secret]']) }
      end
      it { is_expected.to contain_concat__fragment('rspec-key.key-secret').with_source('/etc/named/bind.keys.d/rspec-key.secret') }
    end
  end
end
