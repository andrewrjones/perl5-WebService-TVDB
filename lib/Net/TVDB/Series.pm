use strict;
use warnings;

package Net::TVDB::Series;

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
);

1;
