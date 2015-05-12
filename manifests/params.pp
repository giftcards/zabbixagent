class zabbixagent::params {

  $extensions = []

  $mysqlAgentUser = 'zabbixagentuser'
  $mysqlAgentPassword = 'zabbixagentpassword'

  $zabbixPassive = 'localhost'
  $startAgents = 0
  $zabbixActive = 'zabbix.example.org'
  $enableRemoteCommands = false
  $logRemoteCommands = true

  $packages = [ 'zabbix', 'zabbix-agent' ]
  $nopackages = [ 'zabbix22', 'zabbix22-agent' ]
  $services = [ 'zabbix-agent' ]

}
