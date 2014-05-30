# Create cnf file for user
define mysql::my_cnf_pass (
  $user,
  $password    = 'UNSET',
  $dbuser      = $user,
  $path        = "/home/${user}/.my.cnf",
  $host        = 'localhost',
  $socket      = '/var/run/mysqld/mysqld.sock',
  $ensure      = 'present'
) {
    file { $path:
      ensure  => $ensure,
      content => template('mysql/my.cnf.pass.erb'),
      owner   => $user,
      mode    => '0600',
      require => Mysql_user["${dbuser}@${host}"]
    }
}
