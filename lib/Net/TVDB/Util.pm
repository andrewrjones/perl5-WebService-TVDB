package Net::TVDB::Util;

use strict;
use warnings;

# ABSTRACT: Utility functions

require Exporter;
our @ISA       = qw(Exporter);
our @EXPORT_OK = qw(pipes_to_array);

sub pipes_to_array {
    my $string = shift;
    return unless $string;

    my @array;
    for ( split( /\|/, $string ) ) {
        next unless $_;
        push @array, $_;
    }

    return \@array;
}

__END__

=head1 SYNOPSIS

  use Net::TVDB::Util qw(pipes_to_array);

=method pipes_to_array($string)

Takes a string such as "|Comedy|Action|" and returns an array without the pipes.

=cut
