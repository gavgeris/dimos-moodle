<?php

unset($CFG);
global $CFG;
$CFG = new stdClass();

$CFG->dbtype = 'mariadb';
$CFG->dblibrary = 'native';
$CFG->dbhost = 'mariadb';
$CFG->dbname = 'bitnami_moodle';
$CFG->dbuser = 'bn_moodle';
$CFG->dbpass = getenv('MARIADB_PASSWORD');
$CFG->prefix = 'mdl_';
$CFG->dboptions = array(
    'dbcollation' => 'utf8mb4_unicode_ci',
);

$CFG->wwwroot = getenv('MOODLE_WWWROOT') ?: 'https://yourdomain.com';
$CFG->dataroot = '/var/www/moodledata';
$CFG->admin = 'admin';
$CFG->sslproxy = true;

$CFG->debug = 0;
$CFG->debugdisplay = false;

// Redis session/cache
$CFG->session_handler_class = '\core\session\redis';
$CFG->session_redis_host = 'redis';
$CFG->session_redis_port = 6379;

$CFG->directorypermissions = 02777;

require_once(__DIR__ . '/lib/setup.php');