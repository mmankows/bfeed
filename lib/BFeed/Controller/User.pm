package BFeed::Controller::User;
use strict;
use warnings;

use base 'BFeed::Controller';


sub post_prettify {
    my ($self, $req) = @_;
    delete $req->{user_id};
    return $req;
}


1;
