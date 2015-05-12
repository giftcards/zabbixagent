class zabbixagent (

  $hostMetadata,
  $extensions = $zabbixagent::params::extensions,

  $mysqlAgentUser = $zabbixagent::params::mysqlAgentUser,
  $mysqlAgentPassword = $zabbixagent::params::mysqlAgentPassword,

  $zabbixPassive = $zabbixagent::params::zabbixPassive,
  $zabbixActive = $zabbixagent::params::zabbixActive,
  $enableRemoteCommands = $zabbixagent::params::enableRemoteCommands,
  $startAgents = $zabbixagent::params::startAgents,
  $logRemoteCommands = $zabbixagent::params::logRemoteCommands,

) inherits zabbixagent::params
{

  $packages = $zabbixagent::params::packages
  $nopackages = $zabbixagent::params::nopackages
  $services = $zabbixagent::params::services

  $enableRemoteCommandsBool = $enableRemoteCommands ? {
    true  => '1',
    false => '0',
  }

  $logRemoteCommandsBool = $enableRemoteCommands ? {
    true  => '1',
    false => '0',
  }

  include zabbixagent::packages
  include zabbixagent::services
  include zabbixagent::config
}
