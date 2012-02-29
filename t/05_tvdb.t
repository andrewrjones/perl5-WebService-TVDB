#!perl

use strict;
use warnings;

use Test::More tests => 9;
use Test::Exception;

use XML::Simple qw(:strict);
use FindBin qw($Bin);

BEGIN { use_ok('WebService::TVDB'); }

my $tvdb;           # WebService::TVDB object
my $series_list;    # array ref of WebService::TVDB::Series
my $series;         # a WebService::TVDB::Series

# get a new object
$tvdb = WebService::TVDB->new( api_key => 'ABC123' );
isa_ok( $tvdb, 'WebService::TVDB' );

# test slurping the api_key from a file
my $api_key = WebService::TVDB::_get_api_key_from_file("$Bin/resources/tvdb");
is( $api_key, 'ABC123' );

# test parseing search xml
my $xml = XML::Simple::XMLin(
    "$Bin/resources/series.xml",
    ForceArray => ['Series'],
    KeyAttr    => 'Series'
);
$series_list = WebService::TVDB::_parse_series( $xml, '1234', {}, {} );
is( @{$series_list}, 2, 'two series results' );
$series = @{$series_list}[0];
isa_ok( $series, 'WebService::TVDB::Series' );
is( $series->SeriesName, 'Men Behaving Badly' );
$series = @{$series_list}[1];
isa_ok( $series, 'WebService::TVDB::Series' );
is( $series->SeriesName, 'Men Behaving Badly (US)' );

# test an error search
throws_ok { $tvdb->search() } qr/search term is required/i,
  'needs an search term';
