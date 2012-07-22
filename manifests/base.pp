class base($home = '/home/vagrant') {

    exec { "update" :
        command => "apt-get update",
        path => "/bin/:/usr/bin/:/usr/local/bin/"
    }

    package { ["unzip", "make", "git-core", "vim"] :
        ensure => present,
        require => Exec["update"]
    }

    $home_bin = "${home}/bin"
    file { $home_bin :
        ensure => directory,
        mode => 644
    }

    $profile = "${home}/.bash_profile"
    file { $profile :
        ensure => present,
        content => "#add ~/bin to path\nPATH=\$PATH:/${home}/bin;\nexport PATH;\n"
    }

}
