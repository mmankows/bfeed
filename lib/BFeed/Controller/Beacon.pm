package BFeed::Controller::Beacon;
require Mojo::Util;
use strict;
use warnings;

use base 'BFeed::Controller';

#@
sub post {
    my ($self) = @_;
    $self->req->json->{short_id} = Mojo::Util::md5_sum( join('#', map { $self->req->json->{$_} } qw/uu_id major_id minor_id/ ) );
    return $self->SUPER::post();
}

#@ 
sub put {
    my ($self) = @_;
    $self->req->json->{short_id} = Mojo::Util::md5_sum( join('#', map { $self->req->json->{$_} } qw/uu_id major_id minor_id/ ) );
    return $self->SUPER::put();
}

1;
