# Profile that specify nexus configuration
class profile::nexus (
  $testvar
){
  include ::java
  include ::nexus
  Class['::java'] -> Class['::nexus']
  notify{"$testvar":}
}
