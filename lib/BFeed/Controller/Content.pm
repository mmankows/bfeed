package BFeed::Controller::Content;
use base 'BFeed::Controller';
use JSON::XS;
use DateTime;
use DateTime::Format::MySQL;

sub content_for_beacon {
    my $self = shift;
    my $short_id = $self->stash('short_id');

    my $resp = undef;
    my $status = undef; 
    my $dbh = $self->dbh;
    my $beacon = $dbh->resultset('Beacon')->find( { short_id => $short_id } );

    # There's beacon in the DB
    if ( $beacon ) {
        $self->stash(beacon_id => $beacon->beacon_id);
        my @beacon_rules = $dbh->resultset('Rule')->search( 
            {
                beacon_id => $beacon->beacon_id
            },
            {
                prefetch => 'content',
                order_by => ['content.content_id']
            }
        )->all();

          
        my @rules = $self->_match_rules( \@beacon_rules );
        $self->_log_event( $_ ) foreach @rules;
        
        return $self->render(
            status => 200,
            json => [map {BFeed::Controller::_to_hashref($_->content,qw/url name description img_url/)} @rules]
        );

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
    my @out = ();
    foreach my $rule ( @$rules ) {
          push @out, $rule if $self->_is_rule_matching($rule);
    }
    # filter out unique contents
    my %uniq = ();
    @out = grep { exists $uniq{ $_->content->content_id } ? 0 : ($uniq{$_->content->content_id}=1) } @out;

    return @out;
}

sub _is_rule_matching {
    my ($self, $rule_obj) = @_;

    $rule = $rule_obj->rule();
    return 0 if not $rule;
    
    # Get parameters from client
    my $distance = $self->req->param('dist') || 0;

    $rule = JSON::XS::decode_json($rule);

    # Match global datetime for rule
    if( my $datetime = $rule->{date_from} ) {
        my $dt = DateTime::Format::MySQL->parse_datetime( $datetime );
        return 0 if time < $dt->epoch(); 
    } 

    if( my $datetime = $rule->{date_to} ) {
        my $dt = DateTime::Format::MySQL->parse_datetime( $datetime );
        return 0 if time > $dt->epoch();
    }

    if( my $max_distance = $rule->{distance} ) {
        return 0 if $distance > $max_distance; 
    }

    # Check each day matching
    my @dow_dict = qw/___ MON TUE WED THU FRI SAT SUN/;
    if( my $days = $rule->{days} ) {
        my $matched = 0;
        my $now = DateTime->now();
        foreach my $day ( @$days ) {
            if( $day->{day_of_week} eq $dow_dict[$now->dow()] ) {
                if( $now->hms() gt $day->{hour_from} and
                    $now->hms() lt $day->{hour_to} ) {
                    $matched = 1 and last; 
                }

            }
        } 
        return 0 if not $matched;
    } 
    return 1;
}

sub _log_event {
    my ($self, $rule) = @_;
    
    my $dbh = $self->dbh;
    my $beacon = $dbh->resultset('Beaconlog')->create({ 
        beacon_id =>  $self->stash('beacon_id'),
        content_id => $rule->content_id,
    });
}

1;
