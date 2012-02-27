use strict;
use warnings;

package WebService::TVDB::Actor;

# ABSTRACT: Represents an Actor

# Assessors
# alphabetically, case insensitive
use Object::Tiny qw(
  id
  Image
  Name
  Role
  SortOrder
);

1;

__END__

=attr id

=attr Image

=attr Name

=attr Role

=attr SortOrder

=cut
