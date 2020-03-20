# == Class dns::service
#
class dns::service {
  service { $dns::service:
    ensure     => running,
    hasstatus  => true,
    hasrestart => true,
    enable     => true,
  }
}
