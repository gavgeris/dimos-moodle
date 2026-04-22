<?php

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost = 'mariadb';
$CFG->dbname = 'bitnami_moodle';
$CFG->dbuser = 'bn_moodle';
$CFG->dbpass = getenv('MOODLE_DATABASE_PASSWORD');
$CFG->prefix = 'mdl_';
$CFG->dboptions = array(
    'dbcollation' => 'utf8mb4_unicode_ci',
);

$CFG->wwwroot = getenv('MOODLE_WWWROOT') ?: 'https://yourdomain.com';
$CFG->dataroot = '/var/www/moodledata';
$CFG->admin = 'admin';
$CFG->sslproxy = true;

$CFG->directorypermissions = 02777;

// In config.php — control debug via .env file
if (getenv('MOODLE_DEBUG') === 'true') {
    $CFG->debug        = 32767;
    $CFG->debugdisplay = true;
} else {
    $CFG->debug        = 0;
    $CFG->debugdisplay = false;
}

// Redis session/cache
$CFG->session_handler_class = '\core\session\redis';
$CFG->session_redis_host = 'redis';
$CFG->session_redis_port = 6379;
$CFG->session_redis_database    = 0;         // DB index 0 for sessions
$CFG->session_redis_auth        = '';        // set if your redis has a password
$CFG->session_redis_prefix      = 'mdl_sess_';
$CFG->session_redis_acquire_lock_timeout  = 120;
$CFG->session_redis_lock_expire           = 7200;
$CFG->session_redis_lock_retry            = 100;

// Redis — MUC (Moodle Universal Cache)

// If you don't have tool_forcedcache plugin, use this instead:
//define('CACHE_DISABLE_ALL', false);

$CFG->localcachedir   = '/var/www/moodledata/localcache';
$CFG->tempdir         = '/var/www/moodledata/temp';
$CFG->cachedir        = '/var/www/moodledata/cache';
$CFG->langotherroot   = '/var/www/moodledata/lang';


require_once(__DIR__ . '/lib/setup.php');