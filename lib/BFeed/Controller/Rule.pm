package BFeed::Controller::Rule;
use strict;
use warnings;
use JSON::XS;

use base 'BFeed::Controller';

#@@@ 
sub post {
    my($self) = @_;
    $self->req->json->{rule} = JSON::XS::encode_json($self->req->json->{rule}) if $self->req->json;
    return $self->SUPER::post();
}

#@@@ 
sub put {
    my($self) = @_;
    $self->req->json->{rule} = JSON::XS::encode_json($self->req->json->{rule}) if $self->req->json; 
    return $self->SUPER::put();
}

1;
