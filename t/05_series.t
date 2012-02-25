#!perl

use strict;
use warnings;

use Test::More tests => 35;

use FindBin qw($Bin);
use XML::Simple qw(:strict);

BEGIN { use_ok('Net::TVDB::Series'); }

my $series;    # Net::TVDB::Series object

# empty new
$series = Net::TVDB::Series->new();
isa_ok( $series, 'Net::TVDB::Series' );

# parse actors.xml
my $xml = XML::Simple::XMLin(
    "$Bin/resources/zip/actors.xml",
    ForceArray => 0,
    KeyAttr    => 'Actor'
);
$series->_parse_actors($xml);
my $actors = $series->actors;
is( @$actors, 7, '7 actors' );
for ( @{$actors} ) {
    isa_ok( $_, 'Net::TVDB::Actor' );
}

# check order
my $actor = @{$actors}[0];
is( $actor->id,   44200 );
is( $actor->Name, 'Caroline Quentin' );

# parse banners.xml
$xml = XML::Simple::XMLin(
    "$Bin/resources/zip/banners.xml",
    ForceArray => 0,
    KeyAttr    => 'Banner'
);
$series->_parse_banners($xml);
my $banners = $series->banners;
is( @$banners, 20, '20 banners' );
for ( @{$banners} ) {
    isa_ok( $_, 'Net::TVDB::Banner' );
}

# check order
my $banner = @{$banners}[0];
is( $banner->id,         22614 );
is( $banner->BannerType, 'fanart' );
