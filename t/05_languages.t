#!perl

use strict;
use warnings;

use Test::More tests => 5;

BEGIN { use_ok( 'WebService::TVDB::Languages', qw($languages) ); }

ok( $languages, '$languages is exported' );

ok( $languages->{English}, 'we have English' );
is( $languages->{English}->{id}, '7', 'English has an id' );
is( $languages->{English}->{abbreviation}, 'en',
    'English has an abbreviation' );
