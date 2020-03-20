# == Class dns
#
class dns::install {
  package { $dns::necessary_packages:
    ensure => installed,
  }
}
