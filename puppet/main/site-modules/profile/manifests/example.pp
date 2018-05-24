# A common profile that will include other modules. 
class profile::example {
  notify {'Put things that are common to all nodes here':}
  create_resources(::apache::vhost, hiera_hash('apache::vhost', {}))
}
