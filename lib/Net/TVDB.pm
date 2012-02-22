use strict;
use warnings;

package Net::TVDB;

# ABSTRACT: Interface to http://thetvdb.com/

sub new {
    my $class = shift;
    my $args  = shift;
    my $self  = {};

    bless( $self, $class );
    return $self;
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
