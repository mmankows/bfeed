use lib 'lib';
use DBIx::Class::Schema::Loader qw(make_schema_at dump_to_dir:lib);
use BFeed::Config;
$cfg = BFeed::Config->new();

make_schema_at(
    "BFeed::Model", 
    { debug => 1 }, 
    [ "dbi:mysql:dbname=" . $cfg->db_name,
    $cfg->db_user, 
    $cfg->db_pass ]
);

