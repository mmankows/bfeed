package BFeed::Controller::Content;
use base 'BFeed::Controller';

sub get {
    my $self = shift;
    my $short_id = $self->stash('short_id');

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    my $beacon = $dbh->resultset('Beacon')->find( { short_id => $short_id } );

    # There's beacon in the DB
    if ( $beacon ) {
        my @beacon_rules = $dbh->resultset('Rule')->search( 
            {
                beacon_id => $beacon->beacon_id
            },
            {
                join => 'content',
                order_by => 'rule_id'
            }
        );

        my $rule = $self->_match_rules( $beacon, \@beacon_rules );
        $resp = {
            name => $rule->content->name,
            url => $rule->content->url,
            img_url => $rule->content->img_url,
        };
        $status = 200;
        
    } else {
        $resp   = {};
        $status = 404;
    }

    $self->render( 
        status => $status,
        json => $resp 
    );
}

# sub post {
# sub put {
# sub delete

# TODO implement matching
sub _match_rules {
    my ($self, $req, $rules) = @_;
    shift @$rules;
}

sub _get_beacon_by_shortid {
    my ($self, $dbh, $short_id) = @_;
}

1;
