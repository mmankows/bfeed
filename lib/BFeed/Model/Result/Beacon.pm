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

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 short_id

  data_type: 'char'
  is_nullable: 0
  size: 34

=head2 uu_id

  data_type: 'char'
  is_nullable: 0
  size: 36

=head2 minor_id

  data_type: 'char'
  is_nullable: 0
  size: 36

=head2 major_id

  data_type: 'char'
  is_nullable: 0
  size: 36

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "beacon_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "short_id",
  { data_type => "char", is_nullable => 0, size => 34 },
  "uu_id",
  { data_type => "char", is_nullable => 0, size => 36 },
  "minor_id",
  { data_type => "char", is_nullable => 0, size => 36 },
  "major_id",
  { data_type => "char", is_nullable => 0, size => 36 },
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</beacon_id>

=back

=cut

__PACKAGE__->set_primary_key("beacon_id");

=head1 RELATIONS

=head2 rules

Type: has_many

Related object: L<BFeed::Model::Result::Rule>

=cut

__PACKAGE__->has_many(
  "rules",
  "BFeed::Model::Result::Rule",
  { "foreign.beacon_id" => "self.beacon_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 user

Type: belongs_to

Related object: L<BFeed::Model::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "BFeed::Model::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "RESTRICT", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-12 23:15:56
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:2+0DCTVSF4pb/a9atrckaA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
