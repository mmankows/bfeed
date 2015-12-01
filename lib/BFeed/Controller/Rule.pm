package BFeed::Controller::Rule;
use strict;
use warnings;
use JSON::XS;

use base 'BFeed::Controller';

#@@@
sub get_prettify {
    my($self,$resp) = @_;
    $resp->{rule} = JSON::XS::decode_json($resp->{rule});
    return $resp;
}

#@@@
sub post_prettify {
    my($self,$req_json) = @_;
    $req_json->{rule} = JSON::XS::encode_json($req_json->{rule});
    return $req_json;
}

#@@@
sub put_prettify {
    my($self,$req_json) = @_;
    $req_json->{rule} = JSON::XS::encode_json($req_json->{rule});
    return $req_json;
}

1;
