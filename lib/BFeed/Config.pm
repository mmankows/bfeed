package BFeed::Config;
use strict;
use warnings;
use YAML::Syck;

### Singleton config


my $cfg_path = 'conf.yml';
my $self;

sub new {
    if ( not defined $self ) {
        $self = bless {
            config => YAML::Syck::LoadFile($cfg_path) || die ("Can't read config")
        };
    }
    return $self;
} 

sub db_user {
    my ($self) = @_;
    return $self->{config}{database}{user};
}

sub db_pass {
    my ($self) = @_;
    return $self->{config}{database}{pass};
}

sub db_name {
    my ($self) = @_;
    return $self->{config}{database}{name};
}

sub secret {
    my ($self) = @_;
    return join "", map { chr int rand(255) } 1...20;
}

sub db_data {
    my ($self) = @_;
    
    return (
        "dbi:mysql:dbname=".$self->db_name, 
        $self->db_user, 
        $self->db_pass
    );
}

sub kim_jest_klimek {
    my ($self) = @_;
    return $self->{config}{database}{klimek_to};
}

1;

