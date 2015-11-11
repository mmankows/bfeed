package BFeed::Controller::Content;
use Mojo::Base 'Mojolicious::Controller';

sub get {
  my $self = shift;
  my $beacon_id = $self->stash('beacon_id');
  $self->render( json => {
    content_id => '',
    beacon_id  => $beacon_id,
    url        => 'http://google.com',
    img_url    => 'http://photos.nasza-klasa.pl/5345293/1/square/817858dca7.jpeg?v=0',
    desc       => 'wejć no wejć',
    name       => 'Content na potrzeby testów',
  });
}


1;
