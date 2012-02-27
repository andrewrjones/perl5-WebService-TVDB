use strict;
use warnings;

package Net::TVDB::Episode;

# ABSTRACT: Represents an Episode

# Assessors
# alphabetically, case insensitive
use Object::Tiny qw(
  absolute_number
  airsafter_season
  airsbefore_episode
  airsbefore_season
  Combined_episodenumber
  Combined_season
  DVD_chapter
  DVD_discid
  DVD_episodenumber
  DVD_season
  Director
  EpImgFlag
  EpisodeName
  EpisodeNumber
  filename
  FirstAired
  GuestStars
  id
  IMDB_ID
  Language
  lastupdated
  Overview
  ProductionCode
  Rating
  RatingCount
  seasonid
  SeasonNumber
  seriesid
  Writer
);

sub year {
    my ($self) = @_;
    if ( $self->FirstAired =~ /^(\d{4})-\d{2}-\d{2}$/ ) {
        return $1;
    }
}

1;

__END__

=head1 SYNOPSIS

  my $episode = App::MP4Meta::Source::Data::TVEpisode->new(%data);

=attr absolute_number

=attr airsafter_season

=attr airsbefore_episode

=attr airsbefore_season

=attr Combined_episodenumber

=attr Combined_season

=attr DVD_chapter

=attr DVD_discid

=attr DVD_episodenumber

=attr DVD_season

=attr Director

=attr EpImgFlag

=attr EpisodeName

=attr EpisodeNumber

=attr filename

=attr FirstAired

=attr GuestStars

=attr id

=attr IMDB_ID

=attr Language

=attr lastupdated

=attr Overview

=attr ProductionCode

=attr Rating

=attr RatingCount

=attr seasonid

=attr SeasonNumber

=attr seriesid

=attr Writer

=method year

Parses the FirstAired attribute to get the year it first aired.

=cut
