# Class: mysql::server::params
#
# This class defines default parameters used by the main module class nginx
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to mysql::server class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class mysql::server::params {

  ### Application related parameters

  $package_name = $::operatingsystem ? {
    default => 'mysql-server'
  }

  $enabled = true

  $password = undef

}
