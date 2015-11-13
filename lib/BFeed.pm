package BFeed;
use Mojo::Base 'Mojolicious';
use BFeed::Config;
use Data::Dumper;

use BFeed::Model;


# This method will run once at server start
sub startup {
    my $self = shift;

    my $conf = BFeed::Config->new;
    $self->secrets([$conf->secret]);

    $self->helper( 
       dbh => sub {  
            @_ == 2 ? 
            return BFeed::Model->connect( $conf->db_data() )->resultset($_[1]) 
                :
            return BFeed::Model->connect( $conf->db_data() )
    });
    # Documentation browser under "/perldoc"
    #$self->plugin('PODRenderer');

    # Router
    my $req = $self->routes;

    # Login service
    $req->any('/')->to('login#index')->name('index');
    # Logged user
    #  my $auth = $req->under('/')->to('login#logged_in');
    #  $auth->get('/protected')->to('login#protected');
    my $auth = $req;

    __register_services( $req );
    __register_authorized_services( $auth );
}

sub __register_services {
  my ($route) = @_;

  # Content service 
  $route->get('/beacon/:short_id/content')->to('login#mobile_app')->to('content#content_for_beacon');
}

sub __register_authorized_services {
    my ($authorized_route) = @_;

    my @services = qw/
        content
        beacon
        user
        rule 
    /;

    for my $service ( @services ) {
        $authorized_route->get   ("/$service")    ->to("$service#list"  )->name("list_$service");
        $authorized_route->get   ("/$service/:id")->to("$service#get"   )->name("get_$service");
        $authorized_route->post  ("/$service")    ->to("$service#post"  )->name("add_$service");
        $authorized_route->put   ("/$service/:id")->to("$service#put"   )->name("update_$service");
        $authorized_route->delete("/$service/:id")->to("$service#delete")->name("delete_$service");
    }

}


1;
