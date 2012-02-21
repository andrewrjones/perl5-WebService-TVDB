#!perl

use strict;
use warnings;

use Test::More tests => 3;

use FindBin qw($Bin);

BEGIN { use_ok('Net::TVDB'); }

my $tvdb;    # Net::TVDB object

# get a new object
$tvdb = Net::TVDB->new();
isa_ok( $tvdb, 'Net::TVDB' );

# test slurping the api_key from a file
my $api_key = $tvdb->_get_api_key_from_file("$Bin/resources/.tvdb");
is( $api_key, 'ABC123' );
