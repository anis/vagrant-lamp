# We need a basic apache server
class { 'apache': }
class { 'nodejs':
    version => 'latest'
}

# Let's clone and create a vhost for each of our projects
define project($url) {
    vcsrepo { "/home/vagrant/projects/$name":
        ensure => present,
        provider => git,
        source => $url,
        user => 'vagrant',
        owner => 'vagrant'
    }
    ->
    apache::vhost { "$name.dev":
        port => 80,
        docroot => "/home/vagrant/projects/$name",
        docroot_owner => "vagrant",
        docroot_group => "vagrant"
    }
    ->
    notify { "The vhost $name.dev has been created, make sure to update your hosts file": }
}

create_resources(project, $projects)

apache::vhost { "local.dev":
    port => 80,
    docroot => "/home/vagrant/projects",
    docroot_owner => "vagrant",
    docroot_group => "vagrant"
}
