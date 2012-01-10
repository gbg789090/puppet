class base {
    include sudo, ssh
}

node 'puppet.wdig.com', 'dnhdospocpuppet1.wdig.com' {
    include base
    include puppetmaster
    package { [ 'ntp' ] : ensure => installed }
}

#node 'dnhlearn-test01.wdig.com' {
node /^dnhlearn-test0\d+\.wdig\.com$/ {
    tmpfile { ["foo1", "foo2"]: }
    include base
    include puppetagent
    include postfix
    include mysql
    include apache

    apache::vhost { "dnhlearn-test01.wdig.com" :
        port => 80,
        docroot => "/var/www/html",
        ssl => false,
        priority => 10,
        serveraliases => "dnhlearn-test01",
    }
}

define tmpfile() {
    file { "/tmp/$name" :
        content => "Hello, world!!",
    }
}


