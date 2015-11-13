package BFeed::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub index {
    my $self = shift;

    my $login = $self->param('user') || '';
    my $pass = $self->param('pass') || '';

    my $dbh = $self->dbh;

    my $user = $dbh->resultset('User')->search({login=>$login})->first();
    #return $self->render unless $self->users->check($user, $pass);
    if (not $user or not $pass eq $user->pass) {
        return undef;
    }

    $self->session(
        user => $user,
        user_id => $user->user_id,
    );
    $self->flash(message => 'Thanks for logging in.');
    $self->redirect_to('protected');
}

sub logged_in {
  my $self = shift;
  return 1 if $self->session('user');
  $self->redirect_to('index');
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
  $self->redirect_to('index');
}

1;
