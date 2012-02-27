#!perl

use strict;
use warnings;

use Test::More tests => 1;

use WebService::TVDB::Util qw(pipes_to_array);

my $string   = '|Comedy|Action|';
my @expected = qw(Comedy Action);
is_deeply( pipes_to_array($string), \@expected, 'pipes to array' );
