class zabbixagent::config () inherits zabbixagent {
  require(zabbixagent::packages)

  File {
    ensure  => file,
    owner   => zabbix,
    group   => zabbix,
    mode    => '0640',
    notify => Service[$zabbixagent::services],
  }

  file {
    '/etc/zabbix_agentd.conf.d/':
      ensure => absent,
      force  => true;

    '/etc/zabbix/zabbix_agentd.d/':
      ensure => directory,
      mode   => '0755';

    '/etc/zabbix/zabbix_agentd.conf':
      content => template('zabbixagent/zabbix_agentd.erb'),

  }

  tidy { '/etc/zabbix/zabbix_agentd.d/':
    recurse => 1,
    matches => [ '*.rpmnew' ],
    require => Package[$zabbixagent::packages];
  }

  if 'phpfpm' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_phpfpm.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_phpfpm.conf';

      '/usr/local/bin/phpfpm_stats.sh':
        source => 'puppet:///modules/zabbixagent/phpfpm_stats.sh',
        group  => root,
        mode   => '0755';
    }
  }

  if 'mysqld' in $zabbixagent::extensions or 'mysql' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_mysql.conf';

      '/etc/zabbix/.my.cnf':
        content => template('zabbixagent/my.erb');
    }
  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_mysql.conf': ensure => absent;
      '/etc/zabbix/.my.cnf': ensure => absent;
    }
  }

  if 'memcached' in $zabbixagent::extensions or 'memcache' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_memcached.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_memcached.conf';

      '/usr/local/bin/poll_memcached.sh':
        source => 'puppet:///modules/zabbixagent/poll_memcached.sh',
        group  => root,
        mode   => '0755';

      '/usr/local/bin/discover_memcached.sh':
        source => 'puppet:///modules/zabbixagent/discover_memcached.sh',
        group  => root,
        mode   => '0755';
    }
  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_memcached.conf': ensure => absent;
      '/usr/local/bin/poll_memcached.sh': ensure => absent;
      '/usr/local/bin/discover_memcached.sh': ensure => absent;
    }
  }

  if 'httpd' in $zabbixagent::extensions or 'http' in $zabbixagent::extensions or 'apache' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_apache.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_apache.conf';

      '/usr/local/bin/poll_apache.sh':
        source => 'puppet:///modules/zabbixagent/poll_apache.sh',
        group  => root,
        mode   => '0755';
    }

    if defined(Service['httpd']) {
      file {
        '/etc/httpd/conf.d/server_status.conf':
          source => 'puppet:///modules/zabbixagent/server_status.conf',
          group  => root,
          mode   => '0644',
          notify => Service['httpd'];
      }
    } else {
      warning('httpd service not defined, setup server-status on eth0 ip')
    }
  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_apache.conf': ensure => absent;
      '/usr/local/bin/poll_apache.sh': ensure => absent;
    }

    if defined(Service['httpd']) {
      file { '/etc/httpd/conf.d/server_status.conf': ensure => absent; }
    }
  }

  if 'webmon' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_webmon.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_webmon.conf';
    }
  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_webmon.conf': ensure => absent;
    }
  }

  if 'postfix' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_postfix.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_postfix.conf';
    }

    package { 'postfix-perl-scripts': ensure => installed; }

    cron { 'pflogsum':
      command => '/usr/sbin/pflogsumm /var/log/maillog -d today | head -15 | tail -16 &> /tmp/zabbix_postfix.tmp',
      user    => root,
      minute  => '*/1',
    }
  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_postfix.conf': ensure => absent;
    }

    cron { 'pflogsum': ensure => absent; }

  }

  if 'pidcount' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_pidcount.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_pidcount.conf';
    }
  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_pidcount.conf': ensure => absent,
    }
  }

  if 'rabbitmq' in $zabbixagent::extensions or 'rabbit' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_rabbitmq.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_rabbitmq.conf';

      '/usr/local/bin/poll_rabbit.sh':
        source => 'puppet:///modules/zabbixagent/poll_rabbit.sh',
        mode   => '0755';
    }

  } else {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_rabbitmq.conf': ensure => absent;
      '/usr/local/bin/poll_rabbit.sh': ensure => absent;
    }
  }

  if 'nginx' in $zabbixagent::extensions {
    file {
      '/etc/zabbix/zabbix_agentd.d/userparameter_nginx.conf':
        source => 'puppet:///modules/zabbixagent/userparameter_nginx.conf';
    }
  }
}
