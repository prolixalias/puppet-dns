# == Class dns::config
#
class dns::config {
  file { $dns::cfg_dir:
    ensure => directory,
    owner  => $dns::owner,
    group  => $dns::group,
    mode   => '0755',
  }

  file { $dns::data_dir:
    ensure => directory,
    owner  => $dns::owner,
    group  => $dns::group,
    mode   => '0755',
  }

  file { "${dns::cfg_dir}/bind.keys.d":
    ensure => directory,
    owner  => $dns::owner,
    group  => $dns::group,
    mode   => '0755',
  }

  file { $dns::cfg_file:
    ensure  => present,
    owner   => $dns::owner,
    group   => $dns::group,
    mode    => '0644',
    content => template("${module_name}/named.conf.erb"),
  }

  concat { "${dns::cfg_dir}/named.conf.local":
    owner => $dns::owner,
    group => $dns::group,
    mode  => '0644',
  }

  concat::fragment{'named.conf.local.header':
    target  => "${dns::cfg_dir}/named.conf.local",
    order   => 1,
    content => "// File managed by Puppet.\n"
  }

  # Configure default zones with a concat so we could add more zones in it
  concat {$dns::rfc1912_zones_cfg:
    owner          => $dns::owner,
    group          => $dns::group,
    mode           => '0644',
    ensure_newline => true,
  }

  concat::fragment {'default-zones.header':
    target  => $dns::rfc1912_zones_cfg,
    order   => '00',
    content => template('dns/named.conf.default-zones.erb'),
  }

  file { $dns::default_file:
    ensure  => present,
    owner   => $dns::owner,
    group   => $dns::group,
    mode    => '0644',
    content => template("${module_name}/${dns::default_template}"),
  }
}


# Class[Dns::Default]
# Class[Dns::Params]
# Concat::Fragment[default-zones.header]
# Concat::Fragment[named.conf.local.header]
# Concat[/etc/bind/named.conf.default-zones]
# Concat[/etc/bind/named.conf.local]
# Concat[/etc/named.rfc1912.zones]
# Concat[/etc/named/named.conf.local]
# File[/etc/bind/bind.keys.d/]
# File[/etc/bind/named.conf]
# File[/etc/bind]
# File[/etc/default/bind9]
# File[/etc/named.conf]
# File[/etc/named/bind.keys.d/]
# File[/etc/named]
# File[/etc/sysconfig/named]
# File[/var/lib/bind/zones]
# File[/var/named]
# Package[bind9]
# Package[bind9utils]
# Package[bind]
# Service[bind9]
# Service[named]
