#!perl

use FindBin qw($Bin);
use lib "$Bin/../lib/";

use Code::Generator::Perl;
use LWP::Simple ();
use XML::Simple qw(:strict);
use DateTime;
use File::HomeDir;
use WebService::TVDB::Util qw(get_api_key_from_file);

# Get the current list of languages
my $api_key_file = File::HomeDir->my_home . '/.tvdb';
die 'Can not get API key' unless -e $api_key_file;
my $api_key = get_api_key_from_file($api_key_file);
my $agent = $LWP::Simple::ua->agent;
$LWP::Simple::ua->agent( "WebService::TVDB/$WebService::TVDB::VERSION" );
my $xml = LWP::Simple::get("http://www.thetvdb.com/api/$api_key/languages.xml");
$LWP::Simple::ua->agent( $agent );
die 'Could not get XML' unless $xml;
my $parsed_xml = XML::Simple::XMLin(
    $xml,
    ForceArray => ['Language'],
    KeyAttr    => 'Language'
);

my %languages = map { $_->{name} => $_ } @{ $parsed_xml->{Language} };

# Generate the package
my $generator = new Code::Generator::Perl(
    outdir       => "$Bin/../lib/",
    generated_by => 'tools/generate-languages.pl'
);
$generator->new_package('WebService::TVDB::Languages');

$generator->add_comment(
    'ABSTRACT: A list of languages supported by thetvdb.com');

# Add the code
my $export = <<'HERE';
require Exporter;
our @ISA = qw(Exporter);
our @EXPORT_OK = qw($languages);
HERE
$generator->_add_content($export);

$generator->add( languages => \%languages );

# Generate the POD
my $now = DateTime->now->ymd;
my $pod = <<"HERE";
=encoding utf-8

=head1 SYNOPSIS

  use WebService::TVDB::Languages qw(\$languages);

=head1 DESCRIPTION

This contains all the languages supported by http://thetvdb.com as of $now.

They are as follows:

=over 4

HERE

for ( keys %languages ) {
    $pod .= <<"HERE";
=item *

$_

HERE
}

$pod .= <<'HERE';
=back

=cut
HERE
$generator->_add_content($pod);

# Write to file
$generator->create_or_die();

exit 0;
