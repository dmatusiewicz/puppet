# A common profile that will include other modules. 
class profile::example {

  notify {'Put things that are common to all nodes here':}

  # puppetlabs-java
  # NOTE: Nexus requires
  class{ '::java': 
    package => 'java-1.8.0-openjdk-devel',
  }

  class{ '::nexus':
    version               => '3.11.0',
    revision              => '01',
    download_site         => 'http://download.sonatype.com/nexus/3',
    nexus_type            => 'unix',
    nexus_work_dir_manage => true,
    nexus_root            => '/srv' # All directories and files will be relative to this
  }

  Class['::java'] ->
  Class['::nexus']

}
