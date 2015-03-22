class { '::samba::server':
    workgroup   => 'WORKGROUP',
    interfaces  => [ 'lo', 'eth1' ],
    hosts_allow => [ '127.', '192.168.' ],
    shares      => {
        'vagrant' => [
            'comment = Vagrant file',
            'path = /home/vagrant',
            'browseable = yes',
            'writeable = yes',
            'available = yes'
        ]
    }
}

exec { "Setup samba user for 'vagrant'":
    command => "/bin/echo -e \"${sambaPassword}\n${sambaPassword}\n\" | /usr/bin/smbpasswd -s -a ${sambaUser}"
}