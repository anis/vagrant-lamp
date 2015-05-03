# MongoDB
include '::mongodb::server'
php::pecl::module { "mongo":
    use_package => "no",
}

php::ini { "php_ini_mongo":
    value   => [
        "extension=mongo.so"
    ],
    require => Class["php"]
}

# MySQL
include '::mysql::server'

class {'mysql::bindings':
    php_enable => true
}