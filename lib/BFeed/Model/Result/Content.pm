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

=head2 url

  data_type: 'blob'
  is_nullable: 0

=head2 img_url

  data_type: 'blob'
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "content_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "beacon_id",
  { data_type => "char", is_nullable => 0, size => 34 },
  "name",
  { data_type => "char", is_nullable => 0, size => 255 },
  "desc",
  { data_type => "blob", is_nullable => 0 },
  "url",
  { data_type => "blob", is_nullable => 0 },
  "img_url",
  { data_type => "blob", is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</content_id>

=back

=cut

__PACKAGE__->set_primary_key("content_id");


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-11 15:44:59
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:GorXrXAPNOepklKyAy/pWA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;