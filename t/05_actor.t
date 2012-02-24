#!perl

use strict;
use warnings;

use Test::More tests => 2;

BEGIN { use_ok('Net::TVDB::Actor'); }

my $actor;    # Net::TVDB::Actor object

# empty new
$actor = Net::TVDB::Actor->new();
isa_ok( $actor, 'Net::TVDB::Actor' );
