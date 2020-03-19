# == Class dns
#
class dns (
  $enable_sdb = undef,
  $keytab_file = undef,
  $enable_zone_write = undef,
  $disable_zone_checking = undef,
  $resolvconf = undef,
  $options = undef,
  $rootdir = undef,
  $disable_named_dbus = undef,
){

  contain ::dns::server

}
