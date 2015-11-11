package BFeed::Controller::Login;
use Mojo::Base 'Mojolicious::Controller';

sub index {
  my $self = shift;

  my $user = $self->param('user') || '';
  my $pass = $self->param('pass') || '';
  
  my $dbh = $self->dbh('User');
  my $row = $dbh->find({login=>$user});
  use Data::Dumper;
  warn Dumper $row;
  #return $self->render unless $self->users->check($user, $pass);
  return 1;

  $self->session(user => $user);
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
