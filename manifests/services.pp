class zabbixagent::services {

  require(zabbixagent::config)
  require(zabbixagent::packages)

  Service {
    ensure     => running,
    enable     => true,
    hasrestart => true,
    hasstatus  => true,
  }

  service { $zabbixagent::services: }

}
