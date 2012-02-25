#!perl

use strict;
use warnings;

use Test::More tests => 3;

BEGIN { use_ok('Net::TVDB::Episode'); }

my $episode;    # Net::TVDB::Episode object

# empty new
$episode = Net::TVDB::Episode->new( FirstAired => '1992-10-06' );
isa_ok( $episode, 'Net::TVDB::Episode' );
is( $episode->year, '1992', 'episode year' );
