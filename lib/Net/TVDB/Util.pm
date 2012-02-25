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
