package BFeed::Controller;
use Mojo::Base 'Mojolicious::Controller';
use Mojo::Util;
use Mojo::JSON;
use strict;
use warnings;


sub get_prettify  { return $_[1] };
sub post_prettify { return $_[1] };
sub put_prettify  { return $_[1] };

sub list {
    my ($self) = @_;

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    my %more_params = %{ $self->req->params->to_hash() || {} };
    
    my $user_id    = $self->session('user_id');
    my $controller = Mojo::Util::camelize( $self->stash('controller') );

    eval {
        $resp = [ map {$self->get_prettify(_to_hashref($_)) }  $dbh->resultset( $controller )->search( { %more_params, user_id => $user_id} )->all() ]
    };

    if ( not $@ ) {
        $status = 200;
    } else {
        $status = 400;
    }

    $self->render( 
        status => $status,
        json   => $resp
    );

}

sub get {
    my ($self) = @_;

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    
    my $id         = $self->stash('id'); 
    my $controller = Mojo::Util::camelize( $self->stash('controller') );
    
    $resp = $dbh->resultset($controller)->find($id);

    if ( $resp ) {
        $status = 200;
    } else {
        $status = 404;
    }

    $self->render( 
        status => $status,
        json   => $self->get_prettify(_to_hashref($resp))
    );

}

sub post {
    my ($self) = @_;

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    
    my $id         = $self->stash('id'); 
    my $controller = Mojo::Util::camelize( $self->stash('controller') );


    eval {
        $self->req->json->{user_id} = $self->session('user_id');
        $dbh->resultset( $controller )->create( $self->post_prettify($self->req->json) );
    };

    if ( not $@ ) {
        $status = 200;
    } else {
        print $@;
        $status = 400;
    }

    $self->render( 
        status => $status,
        json   => $resp
    );
}

sub put {
    my ($self) = @_;

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    
    my $id         = $self->stash('id'); 
    my $controller = Mojo::Util::camelize($self->stash('controller'));
    
    my $content = $dbh->resultset( $controller )->find( $id );
    if ( $content ) {
        $content->update( $self->put_prettify($self->req->json) );
        $status = 200;
    } else {
        $status = 404;
    }
    $self->render( 
        status => $status,
        json   => $resp
    );
}

sub delete {
    my ($self) = @_;

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;

    my $id         = $self->stash('id'); 
    my $controller = Mojo::Util::camelize( $self->stash('controller') );
    
    my $content = $dbh->resultset($controller)->find($id);
    if ( $content ) {
        $content->delete();
        $status = 200;
    } else {
        $status = 404;
    }
    $self->render( 
        status => $status,
        json   => $resp
    );
}

sub _to_hashref {
    my ($rs,@cols) = @_;
    return undef if not $rs;
    return {
        map {
            $_ => $rs->get_column( $_ )
        } ( @cols? @cols : $rs->result_source->columns() )
    };
}   

1;
