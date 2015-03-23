# We need a basic apache server
class { 'apache': }

# Let's clone and create a vhost for each of our projects
define project($url) {
    vcsrepo { "/home/vagrant/projects/$name":
        ensure => present,
        provider => git,
        source => $url,
        require => GithubConfig['root']
    }
    ->
    apache::vhost { "$name.dev":
        port => 80,
        docroot => "/home/vagrant/projects/$name"
    }
    ->
    notify { "The vhost $name.dev has been created, make sure to update your hosts file": }
}

create_resources(project, $projects)