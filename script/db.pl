#!/usr/bin/perl
use lib 'lib';
use BFeed::Config;
$cfg = BFeed::Config->new();
($user, $pwd) = $cfg->db_user, $cfg->db_pass;
warn "Setting up database & data...\n";
warn "User: $user  Pass: $pwd\n";
$pwd = $pwd ? "-p$pwd" : '';

qx(cat script/create_database.sql|mysql -u$user $pwd);
qx(perl script/db_to_model.pl);
qx(cat script/sample_data.sql|mysql -u$user $pwd);
