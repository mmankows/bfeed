use utf8;
package BFeed::Model::Result::Beaconlog;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BFeed::Model::Result::Beaconlog

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<beaconlog>

=cut

__PACKAGE__->table("beaconlog");

=head1 ACCESSORS

=head2 beaconlog_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 content_id

  data_type: 'bigint'
  is_nullable: 0

=head2 beacon_id

  data_type: 'bigint'
  is_nullable: 0

=head2 logdate

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "beaconlog_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "content_id",
  { data_type => "bigint", is_nullable => 0 },
  "beacon_id",
  { data_type => "bigint", is_nullable => 0 },
  "logdate",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</beaconlog_id>

=back

=cut

__PACKAGE__->set_primary_key("beaconlog_id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-12 15:01:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:lhZwoSrABzrQfp9o4x6k5w


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
