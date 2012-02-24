#!perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN { use_ok('Net::TVDB::Banner'); }

my $banner;    # Net::TVDB::Banner object

# empty new
$banner = Net::TVDB::Banner->new();
isa_ok( $banner, 'Net::TVDB::Banner' );
