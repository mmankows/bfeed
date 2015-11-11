use utf8;
package BFeed::Model::Result::Rule;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BFeed::Model::Result::Rule

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<rule>

=cut

__PACKAGE__->table("rule");

=head1 ACCESSORS

=head2 rule_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 content_id

  data_type: 'bigint'
  is_nullable: 0

=head2 beacon_id

  data_type: 'char'
  is_nullable: 0
  size: 34

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 desc

  data_type: 'blob'
  is_nullable: 0

=head2 rule

  data_type: 'blob'
  is_nullable: 0

=head2 type

  data_type: 'enum'
  default_value: 'ALLOW'
  extra: {list => ["ALLOW","GET"]}
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "rule_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "content_id",
  { data_type => "bigint", is_nullable => 0 },
  "beacon_id",
  { data_type => "char", is_nullable => 0, size => 34 },
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "desc",
  { data_type => "blob", is_nullable => 0 },
  "rule",
  { data_type => "blob", is_nullable => 0 },
  "type",
  {
    data_type => "enum",
    default_value => "ALLOW",
    extra => { list => ["ALLOW", "GET"] },
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</rule_id>

=back

=cut

__PACKAGE__->set_primary_key("rule_id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-11 15:44:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:HHxtyo1c21kvUgHw3JS0jA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
