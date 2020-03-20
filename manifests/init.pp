# == Class dns
#
class dns (
  Array[String] $necessary_packages,
  Stdlib::Compat::Absolute_path $cfg_dir,
  Stdlib::Compat::Absolute_path $cfg_file,
  Stdlib::Compat::Absolute_path $data_dir,
  Stdlib::Compat::Absolute_path $default_file,
  String $default_template,
  Enum['named', 'bind'] $owner,
  Enum['named', 'bind'] $group,
  Enum['named', 'bind9'] $service,
  String $rfc1912_zones_cfg,
  Array[Hash] $rfc1912_zones
) {
  include dns::install
  include dns::config
  include dns::service

  Class['dns::install']
  -> Class['dns::config']
  ~> Class['dns::service']
}
