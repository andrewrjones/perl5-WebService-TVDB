use strict;
use warnings;

package Net::TVDB::Series;

# ABSTRACT: Represents a TV Series

use Net::TVDB::Actor;
use Net::TVDB::Banner;
use Net::TVDB::Episode;
use Net::TVDB::Util qw(pipes_to_array);

use File::Temp ();
use Archive::Zip qw( :ERROR_CODES :CONSTANTS );
use LWP::Simple ();
use XML::Simple qw(:strict);

# Assessors
# alphabetically, case insensitive
# First section from http://www.thetvdb.com/api/GetSeries.php?seriesname=...
# Second section from <langauge.xml>
# Third section are Net::TVDB:: objects
# Forth section are API values
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

  api_key
  api_language
  api_mirrors
);

# the url for full series data
use constant URL => '%s/api/%s/series/%s/all/%s.zip';

# xml files in the zip
use constant ACTORS_XML_FILE  => 'actors.xml';
use constant BANNERS_XML_FILE => 'banners.xml';

sub fetch {
    my ($self) = @_;

    # get the zip
    my $temp = File::Temp->new();
    unless (
        LWP::Simple::is_success(
            LWP::Simple::getstore( $self->_url, $temp->filename )
        )
      )
    {
        die 'could not get zip file at ' . $self->_url;
    }
    my $zip = Archive::Zip->new();
    unless ( $zip->read( $temp->filename ) == AZ_OK ) {
        die 'could not read zip at ' . $temp->filename;
    }

    # parse the xml files
    my $status;
    my $xml;
    my $parsed_xml;

    my $series_xml_file = $self->language . '.xml';
    ( $xml, $status ) = $zip->contents($series_xml_file);
    unless ( $status == AZ_OK ) {
        die 'could not read ' . $series_xml_file;
    }
    $parsed_xml = XML::Simple::XMLin(
        $xml,
        ForceArray => 0,
        KeyAttr    => 'Data'
    );
    $self->_parse_series_data($parsed_xml);

    ( $xml, $status ) = $zip->contents(ACTORS_XML_FILE);
    unless ( $status == AZ_OK ) {
        die 'could not read ' . ACTORS_XML_FILE;
    }
    $parsed_xml = XML::Simple::XMLin(
        $xml,
        ForceArray => 0,
        KeyAttr    => 'Actor'
    );
    $self->_parse_actors($parsed_xml);

    ( $xml, $status ) = $zip->contents(BANNERS_XML_FILE);
    unless ( $status == AZ_OK ) {
        die 'could not read ' . BANNERS_XML_FILE;
    }
    $parsed_xml = XML::Simple::XMLin(
        $xml,
        ForceArray => 0,
        KeyAttr    => 'Banner'
    );
    $self->_parse_banners($parsed_xml);
}

sub get_episode {
    my ( $self, $season_number, $episode_number ) = @_;

    for my $episode ( @{ $self->episodes } ) {
        if ( $episode->SeasonNumber eq $season_number ) {
            if ( $episode->EpisodeNumber eq $episode_number ) {
                return $episode;
            }
        }

    }
}

# generates the url for full series data
sub _url {
    my ($self) = @_;
    return sprintf( URL,
        $self->api_mirrors->get_mirror,
        $self->api_key, $self->seriesid, $self->api_language->{abbreviation} );
}

# parse <lanugage>.xml
sub _parse_series_data {
    my ( $self, $xml ) = @_;

    # populate extra Series data
    while ( my ( $key, $value ) = each( %{ $xml->{Series} } ) ) {
        if ( $key eq 'Genre' || $key eq 'Actors' ) {
            $self->{$key} = pipes_to_array($value);
        }
        else {
            $self->{$key} = $value;
        }
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

__END__

=method fetch

Fecthes the full data from the TVDB, inluding all the episodes.

=method get_episode ( $season_number, $episode_number )

Gets a parcular episode. Returns a Net::TVDB::Episode object.

=attr banner

=attr FirstAired

=attr id

=attr IMDB_ID

=attr language

=attr Overview

=attr seriesid

=attr SeriesName

=attr zap2it_id

=attr added

Populated after fetch

=attr addedBy

Populated after fetch

=attr Actors

Populated after fetch

=attr Airs_DayOfWeek

Populated after fetch

=attr Airs_Time

Populated after fetch

=attr ContentRating

Populated after fetch

=attr fanart

Populated after fetch

=attr Genre

Populated after fetch

=attr Language

Populated after fetch

=attr lastupdated

Populated after fetch

=attr Network

Populated after fetch

=attr NetworkID

Populated after fetch

=attr poster

Populated after fetch

=attr Rating

Populated after fetch

=attr RatingCount

Populated after fetch

=attr Runtime

Populated after fetch

=attr SeriesID

Populated after fetch

=attr Status

Populated after fetch

=attr actors

An array of Net::TVDB::Actor objects. Poplated after fetch.

=attr banners

An array of Net::TVDB::Banner objects. Poplated after fetch.

=attr episodes

An array of Net::TVDB::Episode objects. Poplated after fetch.

=cut