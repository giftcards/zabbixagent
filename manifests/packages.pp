class zabbixagent::packages {
  Package { notify => Service[$zabbixagent::services], }

  package {$zabbixagent::packages: ensure  => latest, }
  package {$zabbixagent::nopackages: ensure  => absent, }

  if 'phpfpm' in $zabbixagent::extensions {
    package { 'fcgi': ensure => installed, }
  }
}
