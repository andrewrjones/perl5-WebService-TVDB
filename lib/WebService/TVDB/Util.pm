package WebService::TVDB::Util;

use strict;
use warnings;

# ABSTRACT: Utility functions

require Exporter;
our @ISA         = qw(Exporter);
our @EXPORT_OK   = qw(pipes_to_array get_api_key_from_file);
our %EXPORT_TAGS = ( all => \@EXPORT_OK );

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

sub get_api_key_from_file {
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

__END__

=head1 SYNOPSIS

  use WebService::TVDB::Util qw(pipes_to_array);

=method pipes_to_array($string)

Takes a string such as "|Comedy|Action|" and returns an array without the pipes.

=method get_api_key_from_file($file)

Slurps the api_key from file

=cut
