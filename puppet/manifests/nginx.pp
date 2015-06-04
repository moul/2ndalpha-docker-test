package { [
    'nginx',
    'php5-fpm',
    'php5-pgsql'
  ]:
  ensure  => 'installed'
}

service { 'nginx':
	ensure => running,
	require => Package['nginx'],
}

service { 'php5-fpm':
	ensure => running,
	require => Package['php5-fpm'],
}

file { 'web-nginx':
	path => '/etc/nginx/sites-available/web',
	ensure => file,
    replace => true,
	require => Package['nginx'],
	source => '/puppet/conf/nginx/web',
    notify => Service['nginx'],
}

file { 'default-nginx-disable':
	path => '/etc/nginx/sites-enabled/default',
	ensure => absent,
	require => Package['nginx'],
}

file { 'web-nginx-enable':
	path => '/etc/nginx/sites-enabled/web',
	target => '/etc/nginx/sites-available/web',
	ensure => link,
	notify => Service['nginx'],
	require => [
		File['web-nginx'],
		File['default-nginx-disable'],
	],
}