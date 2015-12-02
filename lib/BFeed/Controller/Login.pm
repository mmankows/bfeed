package BFeed::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub auth {
    my $self = shift;

    my $json = $self->req->json() || {};

    my $login = $json->{login} || '';
    my $pass =  $json->{pass} || '';

    my $dbh = $self->dbh;

    my $user = $dbh->resultset('User')->search({login=>$login})->first();
    #return $self->render unless $self->users->check($user, $pass);
    if ( not $user ) {
        $self->render(
            status => 404,
            json => {
                error => 'NOEXIST'
            },
        );
        return undef;
    } elsif ( $user->pass ne $pass ) {
        $self->render(
            status => 401,
            json => {
                error => 'BADPWD'
            }
        );
        return undef;
    } else {
        $self->session(
            user => $user,
            expiration => 360000,
            user_id => $user->user_id,
        );
        return $self->render(
            status => 200,
            json => {}
        );
    }

}

sub logged_in {
  my $self = shift;
  return 1 if $self->session('user');
  
  $self->render( 
      status => 401,
      text => ''
  );
  return undef;
}

sub mobile_app {
  my $self = shift;
  return 1 if 1;
  return undef;
}

sub logout {
  my $self = shift;
  $self->session(expires => 1);
  return $self->render( 
      status => 200,
      text => ''
  );
}

1;
