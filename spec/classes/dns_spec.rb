# frozen_string_literal: true

require 'spec_helper'

describe 'dns' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }

      it { is_expected.to contain_class('dns::install') }
      it { is_expected.to contain_class('dns::config') }
      it { is_expected.to contain_class('dns::service') }
    end
  end
end
