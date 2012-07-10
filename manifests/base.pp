class base($home = '/home/vagrant') {

    package { ["unzip", "make", "git-core", "vim"] :
        ensure => present,
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
