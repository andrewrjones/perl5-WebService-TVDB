use strict;
use warnings;

package Net::TVDB;

# ABSTRACT: Interface to http://thetvdb.com/

use Net::TVDB::Languages qw($languages);
use Net::TVDB::Series;

use LWP::Simple ();
use XML::Simple qw(:strict);

use constant SEARCH_URL =>
  'http://www.thetvdb.com/api/GetSeries.php?seriesname=%s';

sub new {
    my $class = shift;
    my $args  = shift;
    my $self  = {};

    bless( $self, $class );
    return $self;
}

sub search {
    my ( $self, $term ) = @_;

    unless ($term) {
        die 'search term is required';
    }

    my $xml = LWP::Simple::get( sprintf( SEARCH_URL, $term ) );
    $self->{series} =
      _parse_series(
        XML::Simple::XMLin( $xml, ForceArray => 0, KeyAttr => 'Series' ) );

    return $self->{series};
}

# parse the series xml and return an array of Net::TVDB::Series
sub _parse_series {
    my ($xml) = @_;

    # loop over results and create new series objects
    my @series;
    for ( @{ $xml->{Series} } ) {
        push @series, Net::TVDB::Series->new(%$_);
    }

    return \@series;
}

# slurps the api_key from file
sub _get_api_key_from_file {
    my ($file) = @_;

    return do {
        local $/ = undef;
        open my $fh, "<", $file
          or die "could not open $file: $!";
        my $doc = <$fh>;

        # ensure there are no carriage returns
        $doc =~ s/(\r|\n)//g;

        return $doc;
    };
}

1;
