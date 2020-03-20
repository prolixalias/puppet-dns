#== Class dns::collector
#
# ?
class dns::collector {
  Dns::Member <<| |>> {
    require => Class['dns'],
    notify  => Class['dns::service']
  }
}
