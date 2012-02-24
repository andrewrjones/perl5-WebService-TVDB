use strict;
use warnings;

package Net::TVDB::Series;

use Net::TVDB::Actor;

# Assessors
# alphabetically, case insensitive
# from http://www.thetvdb.com/api/GetSeries.php?seriesname=...
use Object::Tiny qw(
  banner
  FirstAired
  id
  IMDB_ID
  language
  Overview
  seriesid
  SeriesName
  zap2it_id

  actors
);

# parse actors.xml
sub _parse_actors {
    my ($xml) = @_;

    my @actors;
    for ( @{ $xml->{Actor} } ) {
        push @actors, Net::TVDB::Actor->new( %{$_} );

    }
    return \@actors;
}

1;
