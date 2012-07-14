class clojure($version = "1.4.0", $home = '/home/vagrant') {

    require base

    Exec { path => "/usr/local/bin/:/bin/:/usr/bin/", }

    package { "openjdk-6-jre-headless":
        ensure => present,
    }

    $clojure_file = "clojure-${version}.zip"
    $clojure_path = "http://repo1.maven.org/maven2/org/clojure/clojure/${version}/${clojure_file}"
    exec { "clj" :
        command => "wget ${clojure_path}; unzip ${clojure_file}; mv clojure-${version} ${home}/clojure;",
        require => [Class["base"], Package["openjdk-6-jre-headless"]],
        creates => "${home}/clojure",
    }

    $lein_path = "https://raw.github.com/technomancy/leiningen/preview/bin/lein"
    $local_lein = "${home}/bin/lein"
    exec { "lein" :
        command => "wget ${lein_path}; mv ./lein ${local_lein}; chmod +x ${local_lein}; ${local_lein};",
        creates => $local_lein,
        require => Class["base"]
    }

    $clj_path = "${home}/bin/clojure"
    $clojure_alias = "java -cp ${home}/clojure/clojure-${version}.jar clojure.main"
    file { $clj_path :
        ensure => present,
        content => "#!/bin/bash\n${clojure_alias}"
    }

    $lein_dir = "${home}/.lein"
    file { $lein_dir :
        ensure => directory,
    }

    $lein_conf = "${home}/.lein/profiles.clj"
    file { $lein_conf :
        require => [Exec["vimcl", "lein"], File[$lein_dir]],
        content => "{:user {:plugins [[lein-tarsier \"0.9.1\"]]}}",
        ensure => present
    }

    $vim_clojure_remote = "https://github.com/stanistan/vimclojure-easy.git"
    $home_vim_dir = "${home}/.vim"

    $clone_command = "git clone ${vim_clojure_remote};"
    # $backup_vim = "mv ${home_vim_dir} ${home_vim_dir}.bak; mv ${home_vim_dir}rc ${home_vim_dir}rc.bak;"
    $backup_vim = ''
    $move = "mv ./vimclojure-easy ${home_vim_dir}; ln -s ${home_vim_dir}/vimrc.vim ${home_vim_dir}rc;"
    $nailgun = "make -C ${home_vim_dir}/lib/vimclojure-nailgun-client;"

    exec { "vimcl" :
        path => "/usr/local/bin/:/bin/:/usr/bin/",
        command => "${clone_command} ${backup_vim} ${move} ${nailgun}",
        creates => "${home_vim_dir}/piglatin.clj",
        require => Exec["lein"]
    }
}
