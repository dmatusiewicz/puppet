# Profile that specify nexus configuration
class profile::nexus {
  include ::java
  include ::nexus
  Class['::java'] -> Class['::nexus']
}
