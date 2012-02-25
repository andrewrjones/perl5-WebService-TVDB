#!perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN { use_ok('Net::TVDB::Episode'); }

my $episode;    # Net::TVDB::Episode object

# empty new
$episode = Net::TVDB::Episode->new();
isa_ok( $episode, 'Net::TVDB::Episode' );
