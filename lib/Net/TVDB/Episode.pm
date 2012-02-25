use strict;
use warnings;

package Net::TVDB::Episode;

# ABSTRACT: Represents an Episode

# Assessors
# alphabetically, case insensitive
use Object::Tiny qw(
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
  FirstAired
  GuestStars
  id
  IMDB_ID
  Language
  Overview
  ProductionCode
  Rating
  RatingCount
  SeasonNumber
  Writer
  absolute_number
  airsafter_season
  airsbefore_episode
  airsbefore_season
  filename
  lastupdated
  seasonid
  seriesid
);

sub year {
    my ($self) = @_;
    if ( $self->FirstAired =~ /^(\d{4})-\d{2}-\d{2}$/ ) {
        return $1;
    }
}

1;
