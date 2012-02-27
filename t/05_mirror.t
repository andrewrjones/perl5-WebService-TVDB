#!perl

use strict;
use warnings;

use Test::More tests => 5;
use Test::Exception;

use XML::Simple qw(:strict);
use FindBin qw($Bin);
use File::HomeDir;

use WebService::TVDB;

BEGIN { use_ok('WebService::TVDB::Mirror'); }

my $mirror;        # WebService::TVDB::Mirror object
my $mirror_url;    # URL to the mirror

# get a new object
$mirror = WebService::TVDB::Mirror->new();
isa_ok( $mirror, 'WebService::TVDB::Mirror' );

# test getting a mirror from XML
$mirror->{mirrors} = XML::Simple::XMLin(
    "$Bin/resources/mirrors.xml",
    ForceArray => 0,
    KeyAttr    => []
);
$mirror_url = $mirror->get_mirror();
is( $mirror_url, 'http://thetvdb.com' );

# need an API key
throws_ok { $mirror->fetch_mirror_list() } qr/API key/i, 'needs an API key';

# need a correct API key
throws_ok { $mirror->fetch_mirror_list('foo') } qr/Could not get mirrors/i,
  'Could not get mirrors';
