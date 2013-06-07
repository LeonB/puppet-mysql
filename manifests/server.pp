class mysql::server(
  $package_name = params_lookup( 'package_name' ),
  $enabled      = params_lookup( 'enabled' ),
  $password     = params_lookup( 'password' ),
  ) inherits mysql::server::params {

      validate_string($password)

        $ensure = $enabled ? {
                true => present,
                false => absent
        }

  include mysql::server::package, mysql::server::config, mysql::server::service
}
