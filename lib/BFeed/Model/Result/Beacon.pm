use utf8;
package BFeed::Model::Result::Beacon;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BFeed::Model::Result::Beacon

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<beacon>

=cut

__PACKAGE__->table("beacon");

=head1 ACCESSORS

=head2 beacon_id

  data_type: 'char'
  is_nullable: 0
  size: 34

=head2 user_id

  data_type: 'bigint'
  is_nullable: 0

=head2 minor_id

  data_type: 'char'
  is_nullable: 0
  size: 34

=head2 major_id

  data_type: 'char'
  is_nullable: 0
  size: 34

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'blob'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "beacon_id",
  { data_type => "char", is_nullable => 0, size => 34 },
  "user_id",
  { data_type => "bigint", is_nullable => 0 },
  "minor_id",
  { data_type => "char", is_nullable => 0, size => 34 },
  "major_id",
  { data_type => "char", is_nullable => 0, size => 34 },
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "description",
  { data_type => "blob", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</beacon_id>

=back

=cut

__PACKAGE__->set_primary_key("beacon_id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-11 15:44:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8fQL9OP8ck9yuWXxs6HZaw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
