#!perl

use strict;
use warnings;

use Test::More tests => 2;

use FindBin qw($Bin);

BEGIN { use_ok('Net::TVDB::Series'); }

my $series;    # Net::TVDB::Series object

# empty new
$series = Net::TVDB::Series->new();
isa_ok( $series, 'Net::TVDB::Series' );
