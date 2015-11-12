use utf8;
package BFeed::Model::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

BFeed::Model::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 user_id

  data_type: 'bigint'
  is_auto_increment: 1
  is_nullable: 0

=head2 login

  data_type: 'char'
  is_nullable: 0
  size: 32

=head2 pass

  data_type: 'char'
  is_nullable: 0
  size: 32

=head2 email

  data_type: 'char'
  is_nullable: 0
  size: 64

=head2 role

  data_type: 'enum'
  extra: {list => ["STANDARD","ADMIN"]}
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "bigint", is_auto_increment => 1, is_nullable => 0 },
  "login",
  { data_type => "char", is_nullable => 0, size => 32 },
  "pass",
  { data_type => "char", is_nullable => 0, size => 32 },
  "email",
  { data_type => "char", is_nullable => 0, size => 64 },
  "role",
  {
    data_type => "enum",
    extra => { list => ["STANDARD", "ADMIN"] },
    is_nullable => 1,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 RELATIONS

=head2 beacons

Type: has_many

Related object: L<BFeed::Model::Result::Beacon>

=cut

__PACKAGE__->has_many(
  "beacons",
  "BFeed::Model::Result::Beacon",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07043 @ 2015-11-12 15:01:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:CoqSE3FMeT1bvDSEKd9VTA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
sub check {
    my ($self, $user, $passwd) = @_;
    
    use Data::Dumper;
    print Dumper $self->resultset->find( { login => $user } );
    return 0;
    
}

1;
