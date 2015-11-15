package BFeed::Controller::Content;
use base 'BFeed::Controller';

sub content_for_beacon {
    my $self = shift;
    my $short_id = $self->stash('short_id');

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    my $beacon = $dbh->resultset('Beacon')->find( { short_id => $short_id } );

    # There's beacon in the DB
    if ( $beacon ) {
        $self->stash( beacon_id => $beacon->beacon_id );
        my @beacon_rules = $dbh->resultset('Rule')->search( 
            {
                beacon_id => $beacon->beacon_id
            },
            {
                join => 'content',
                order_by => 'rule_id'
            }
        );
          
        my $rule = $self->_match_rules( \@beacon_rules );
        print "BID: " . $self->stash('beacon_id');
        $self->_log_event( $rule );
	    return $self->stash(id => $rule->content_id)->get() if $rule;
        
    } else {
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
# rules -
#  godzina
#  dzien_tygodnia
#
#
#  
sub _match_rules {
    my ($self, $rules) = @_;

    # get first matching rules
    foreach my $rule ( @$rules ) {
       return $rule if $self->_is_rule_matching($rule);
    }
    return undef;
}

sub _is_rule_matching {
    my ($self, $rule_obj) = @_;
    my $rule = $rule_obj->rule;
    return 1;
}

sub _get_beacon_by_shortid {
    my ($self, $dbh, $short_id) = @_;
}

sub _log_event {
    my ($self, $rule) = @_;
    
    my $dbh = $self->dbh;
    my $content_id = $rule ? $rule->content_id : 0;
    my $beacon = $dbh->resultset('Beaconlog')->create({ 
        beacon_id =>  $self->stash('beacon_id'),
        content_id => $content_id,
    });
}

1;
