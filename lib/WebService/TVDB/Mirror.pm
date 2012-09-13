use strict;
use warnings;

package WebService::TVDB::Mirror;

# ABSTRACT: Gets and saves a mirror

use LWP::Simple ();
use XML::Simple qw(:strict);

use constant MIRRORS_URL => 'http://www.thetvdb.com/api/%s/mirrors.xml';

sub new {
    my $class = shift;
    my $args  = shift;
    my $self  = {};

    bless( $self, $class );
    return $self;
}

sub fetch_mirror_list {
    my ( $self, $api_key ) = @_;

    unless ($api_key) {
        die 'Need an API key';
    }

    my $agent = $LWP::Simple::ua->agent;
    $LWP::Simple::ua->agent( "WebService::TVDB/$WebService::TVDB::VERSION" );
    my $xml = LWP::Simple::get( sprintf( MIRRORS_URL, $api_key ) );
    $LWP::Simple::ua->agent( $agent );

    unless ($xml) {
        die "Could not get mirrors.xml";
    }

    $self->{mirrors} =
      XML::Simple::XMLin( $xml, ForceArray => 0, KeyAttr => [] );
}

sub get_mirror {
    my ($self) = @_;

    if ( defined $self->{mirrors} ) {
        return $self->{mirrors}->{Mirror}->{mirrorpath};
    }
    return;
}

1;

=head1 SYNOPSIS

  my $mirror = WebService::TVDB::Mirror->new();
  $mirror->fetch_mirror_list('1234abcd');
  my $mirror_url = $mirror->get_mirror();
  
=method new()

Create a new object. Takes no arguments.

=method fetch_mirror_list($api_key)

Fetches the mirror list from thetvdb.com. Requires an API key, or will die.

=method get_mirror()

Gets a mirror. You will need to have called fetch_mirror_list() before.
