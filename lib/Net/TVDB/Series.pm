use strict;
use warnings;

package Net::TVDB::Series;

# ABSTRACT: Represents a TV Series

use Net::TVDB::Actor;
use Net::TVDB::Banner;
use Net::TVDB::Episode;

# Assessors
# alphabetically, case insensitive
# First section from http://www.thetvdb.com/api/GetSeries.php?seriesname=...
# Second section from <langauge.xml>
# Third section are Net::TVDB:: objects
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

  added
  addedBy
  Actors
  Airs_DayOfWeek
  Airs_Time
  ContentRating
  fanart
  Genre
  Language
  lastupdated
  Network
  NetworkID
  poster
  Rating
  RatingCount
  Runtime
  SeriesID
  Status

  actors
  banners
  episodes
);

# parse <lanugage>.xml
sub _parse_series_data {
    my ( $self, $xml ) = @_;

    # populate extra Series data
    while ( my ( $key, $value ) = each( %{ $xml->{Series} } ) ) {
        $self->{$key} = $value;
    }

    # populate Episodes
    my @episodes;
    for ( @{ $xml->{Episode} } ) {
        push @episodes, Net::TVDB::Episode->new( %{$_} );

    }
    $self->{episodes} = \@episodes;
    return $self->{episodes};
}

# parse actors.xml
sub _parse_actors {
    my ( $self, $xml ) = @_;

    my @actors;
    for ( @{ $xml->{Actor} } ) {
        push @actors, Net::TVDB::Actor->new( %{$_} );

    }
    $self->{actors} = \@actors;
    return $self->{actors};
}

# parse banners.xml
sub _parse_banners {
    my ( $self, $xml ) = @_;

    my @banners;
    for ( @{ $xml->{Banner} } ) {
        push @banners, Net::TVDB::Banner->new( %{$_} );

    }
    $self->{banners} = \@banners;
    return $self->{banners};
}

1;
