#
class mysql::server::root_password {

  $options = $mysql::server::options

  # manage root password if it is set
  if $mysql::server::root_password != 'UNSET' {
    mysql_user { 'root@localhost':
      ensure        => present,
      password_hash => mysql_password($mysql::server::root_password),
    }

    ::mysql::my_cnf_pass { "${::root_home}/.my.cnf":
      user     => 'root',
      password => $mysql::server::root_password,
      path     => "${::root_home}/.my.cnf",
      host     => 'localhost',
      socket   => $options['client']['socket']
    }
  }
}
