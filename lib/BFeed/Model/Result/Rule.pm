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

=head2 user_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 content_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 beacon_id

  data_type: 'bigint'
  is_foreign_key: 1
  is_nullable: 0

=head2 name

  data_type: 'char'
  is_nullable: 0
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 0

=head2 rule

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "rule_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "content_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "beacon_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "rule",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</rule_id>

=back

=cut

__PACKAGE__->set_primary_key("rule_id");

=head1 RELATIONS

=head2 beacon

Type: belongs_to

Related object: L<BFeed::Model::Result::Beacon>

=cut

__PACKAGE__->belongs_to(
  "beacon",
  "BFeed::Model::Result::Beacon",
  { beacon_id => "beacon_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 content

Type: belongs_to

Related object: L<BFeed::Model::Result::Content>

=cut

__PACKAGE__->belongs_to(
  "content",
  "BFeed::Model::Result::Content",
  { content_id => "content_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-24 19:48:07
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:EmU5kinw7XhPlZ1zn9hieA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
