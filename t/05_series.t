#!perl

use strict;
use warnings;

use Test::More tests => 12;

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
my $actors = Net::TVDB::Series::_parse_actors($xml);
is( @$actors, 7, '7 actors' );
for ( @{$actors} ) {
    isa_ok( $_, 'Net::TVDB::Actor' );
}
my $actor = @{$actors}[0];
is( $actor->id,   44200 );
is( $actor->Name, 'Caroline Quentin' );
