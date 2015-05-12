## Synopsis  
  
Puppet module to setup zabbix agents. This module is one of the oldest and needs a lot of cleanup done on the extensions.  
  
## Example  
  
Defaults are stored in params.pp.  
  
## Motivation  
  
Required to setup zabbix monitoring for all of our infrastructure and production instances.  
  
## Installation  
  
Tested on CentOS 6 and CentOS 5  
Requires the zabbix and zabbix contrib repositories https://www.zabbix.com/documentation/2.2/manual/installation/install_from_packages.  
Obviously requires a working zabbix installation.  
  
## API Reference  
  
hostMetadata => metadata to assign to the zabbix agent, usually used for automatic registration  
extensions => list of zabbix extensions to install, see extensions  
mysqlAgentUser => mysql user for mysql monitoring  
mysqlAgentPassword => password for the mysql user  
zabbixPassive => zabbix passive server/zabbix proxy  
zabbixActive => zabbix active server/zabbix proxy  
enableRemoteCommands => whether or not to enable remote commands  
startAgents => how many agent pids to start  
logRemoteCommands => true/false, whether or not to log remote commands run on the agent  
  
## Extensions  
  
Various userparameter files and associated scripts for pulling data to be pulled into zabbix. These extensions were built on the fly and many require a lot of cleanup work. See config.pp for details on what each of these do.  
  
phpfpm  
mysqld/mysql  
memcached/memcache  
httpd/http  
webmon  
postfix  
pidcount  
rabbitmq  
nginx  
  
## Contributors  
  
Ryan Munz for Giftcards.com - May 2015  
