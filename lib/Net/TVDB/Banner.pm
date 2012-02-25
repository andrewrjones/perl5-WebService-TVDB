use strict;
use warnings;

package Net::TVDB::Banner;

# ABSTRACT: Represents a Banner

# Assessors
# alphabetically, case insensitive
use Object::Tiny qw(
  BannerPath
  BannerType
  BannerType2
  Colors
  id
  Language
  Rating
  RatingCount
  Season
  SeriesName
  ThumbnailPath
  VignettePath
);

use constant URL => 'http://thetvdb.com/banners/%s';

sub url {
    my ($self) = @_;
    return sprintf( URL, $self->BannerPath );
}

1;

__END__

=attr BannerPath

=attr BannerType

=attr BannerType2

=attr Colors

=attr id

=attr Language

=attr Rating

=attr RatingCount

=attr Season

=attr SeriesName

=attr ThumbnailPath

=attr VignettePath

=cut
