package BFeed;
use Mojo::Base 'Mojolicious';
use BFeed::Config;
use Data::Dumper;

use BFeed::Model;


# This method will run once at server start
sub startup {
    my $self = shift;

    my $conf = BFeed::Config->new;
    $self->hook(
        before_dispatch => sub {
        my $c = shift;
        $c->res->headers->header('Access-Control-Allow-Origin' => '*');
#        $c->res->headers->header('Access-Control-Allow-Credentials' => 'true');
        $c->res->headers->header('Access-Control-Allow-Methods' => 'POST, PUT, DELETE, GET, OPTIONS');
#        $c->res->headers->header('Access-Control-Request-Methods' => '*');
        $c->res->headers->header('Access-Control-Allow-Headers' => 'Origin, Cookie, X-Requested-With, Content-Type, Accept, Authorization');
#        $c->res->headers->header('Authorization' => $c->res->headers->header('Set-Cookie'));
        },
        
    );
    $self->secrets([$conf->secret]);

    $self->plugin(AccessLog => {log => 'log/access.log'});

    $self->helper( 
       dbh => sub {  
            @_ == 2 ? 
            return BFeed::Model->connect( $conf->db_data() )->resultset($_[1]) 
                :
            return BFeed::Model->connect( $conf->db_data() )
    });

    # Router
    my $req = $self->routes;
    __register_services( $req );

    # Logged user
    my $auth = $req->under('/api')->to('login#logged_in');
    __register_authorized_services( $auth );
}

sub __register_services {
    my ($route) = @_;

    # Content service 
    $route->post('/auth')->to('login#auth');
    $route->get( '/api/beacon/:short_id/content')->to('login#mobile_app')->to('content#content_for_beacon');
    $route->post('/user')->to('user#post')->name('add_user');
    $route->options('*'=> sub {
        my $c = shift;
        $c->res->headers->header('Access-Control-Allow-Origin' => '*');
#        $c->res->headers->header('Access-Control-Allow-Credentials' => 'true');
        $c->res->headers->header('Access-Control-Allow-Methods' => 'POST, PUT, DELETE, GET, OPTIONS');
#        $c->res->headers->header('Access-Control-Request-Methods' => '*');
        $c->res->headers->header('Access-Control-Allow-Headers' => 'Origin, Cookie, X-Requested-With, Content-Type, Accept, Authorization');


        $c->respond_to(any => { data => '', status => 200 });
  });

}

sub __register_authorized_services {
    my ($authorized_route) = @_;

    my @services = qw/
        content
        beacon
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
