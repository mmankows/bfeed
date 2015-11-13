use utf8;
package BFeed::Model::Result::Content;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BFeed::Model::Result::Content

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<content>

=cut

__PACKAGE__->table("content");

=head1 ACCESSORS

=head2 content_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

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

=head2 url

  data_type: 'text'
  is_nullable: 0

=head2 img_url

  data_type: 'text'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "content_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "bigint", is_foreign_key => 1, is_nullable => 0 },
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "description",
  { data_type => "text", is_nullable => 0 },
  "url",
  { data_type => "text", is_nullable => 0 },
  "img_url",
  { data_type => "text", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</content_id>

=back

=cut

__PACKAGE__->set_primary_key("content_id");

=head1 RELATIONS

=head2 rules

Type: has_many

Related object: L<BFeed::Model::Result::Rule>

=cut

__PACKAGE__->has_many(
  "rules",
  "BFeed::Model::Result::Rule",
  { "foreign.content_id" => "self.content_id" },
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


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-13 01:27:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6z0Y6eaauQfMQZdWzC/1jg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
