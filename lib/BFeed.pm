package BFeed;
use Mojo::Base 'Mojolicious';
use Data::Dumper;

use BFeed::Model;


# This method will run once at server start
sub startup {
  my $self = shift;

  $self->secrets(['|<7!m3K@t0#z138']);


  $self->helper( dbh => sub {  return BFeed::Model->connect("dbi:mysql:dbname=bfeed_data", 'root', '')->resultset($_[1]) });

  # Documentation browser under "/perldoc"
  #$self->plugin('PODRenderer');

  # Router
  my $req = $self->routes;

  # Login service
  $req->any('/')->to('login#index')->name('index');
  # Logged user
  my $auth = $req->under('/')->to('login#logged_in');
  $auth->get('/protected')->to('login#protected');
  
  # Content service 
  $req->get    ('/content/:beacon_id')->to('login#mobile_app')->to('content#get')->name('get_content');
  $auth->post  ('/content/:beacon_id')->to('content#add')->name('add_content');
  $auth->put   ('/content/:beacon_id/:content_id')->to('content#update')->name('update_content');
  $auth->delete('/content/:beacon_id/:content_id')->to('content#delete')->name('delete_content');

}


1;
