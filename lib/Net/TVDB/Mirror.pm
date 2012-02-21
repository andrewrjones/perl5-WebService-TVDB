use strict;
use warnings;

package Net::TVDB::Mirror;

# ABSTRACT: Gets and saves a mirror

use constant MIRRORS_URL => ' http://www.thetvdb.com/api/%s/mirrors.xml';

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

    require LWP::Simple;
    require XML::Simple;

    my $xml = LWP::Simple::get( sprintf( MIRRORS_URL, $api_key ) );
    $self->{mirrors} = XML::Simple::XMLin($xml);
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

  my $mirror = Net::TVDB::Mirror->new();
  $mirror->fetch_mirror_list('1234abcd');
  my $mirror_url = $mirror->get_mirror();
  
=method new()

Create new object. Takes no arguments.

=for :list
* api_key - Your TVDB API key. Required. Will die if not present.

=method fetch_mirror_list($api_key)

Fetches the mirror list from thetvdb.com. Requires an API key, or will die.

=method get_mirror()

Gets a mirror. You will need to have called fetch_mirror_list() before.
