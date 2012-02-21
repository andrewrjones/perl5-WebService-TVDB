#!perl

use strict;
use warnings;

use Test::More tests => 6;
use Test::Exception;

require XML::Simple;
use FindBin qw($Bin);
use File::HomeDir;

use Net::TVDB;

BEGIN { use_ok('Net::TVDB::Mirror'); }

my $mirror;        # Net::TVDB::Mirror object
my $mirror_url;    # URL to the mirror

# get a new object
$mirror = Net::TVDB::Mirror->new();
isa_ok( $mirror, 'Net::TVDB::Mirror' );

# test getting a mirror from XML
$mirror->{mirrors} = XML::Simple::XMLin("$Bin/resources/mirrors.xml");
$mirror_url = $mirror->get_mirror();
is( $mirror_url, 'http://thetvdb.com' );

# need an API key
throws_ok { $mirror->fetch_mirror_list() } qr/API key/i, 'needs an API key';

# need a correct API key
throws_ok { $mirror->fetch_mirror_list('foo') } qr/Could not get mirrors/i,
  'Could not get mirrors';

# live test, fetching from http://thetvdb.com
my $tvdb = Net::TVDB->new();
$mirror->fetch_mirror_list(
    $tvdb->_get_api_key_from_file( File::HomeDir->my_home . '/.tvdb' ) );
$mirror_url = $mirror->get_mirror();
is( $mirror_url, 'http://thetvdb.com' );
