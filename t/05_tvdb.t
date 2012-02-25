#!perl

use strict;
use warnings;

use Test::More tests => 9;
use Test::Exception;

use XML::Simple qw(:strict);
use FindBin qw($Bin);

BEGIN { use_ok('Net::TVDB'); }

my $tvdb;           # Net::TVDB object
my $series_list;    # array ref of Net::TVDB::Series
my $series;         # a Net::TVDB::Series

# get a new object
$tvdb = Net::TVDB->new();
isa_ok( $tvdb, 'Net::TVDB' );

# test slurping the api_key from a file
my $api_key = Net::TVDB::_get_api_key_from_file("$Bin/resources/tvdb");
is( $api_key, 'ABC123' );

# test parseing search xml
my $xml = XML::Simple::XMLin(
    "$Bin/resources/series.xml",
    ForceArray => ['Series'],
    KeyAttr    => 'Series'
);
$series_list = Net::TVDB::_parse_series( $xml, '1234', {}, {} );
is( @{$series_list}, 2, 'two series results' );
$series = @{$series_list}[0];
isa_ok( $series, 'Net::TVDB::Series' );
is( $series->SeriesName, 'Men Behaving Badly' );
$series = @{$series_list}[1];
isa_ok( $series, 'Net::TVDB::Series' );
is( $series->SeriesName, 'Men Behaving Badly (US)' );

# test an error search
throws_ok { $tvdb->search() } qr/search term is required/i,
  'needs an search term';
