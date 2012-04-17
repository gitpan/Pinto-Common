# ABSTRACT: Something that has a pause config attribute

package Pinto::Role::Attribute::pausecfg;

use Moose::Role;

use MooseX::Types::Moose qw(HashRef);
use Pinto::Types qw(File);

use Path::Class;
use File::HomeDir;

#------------------------------------------------------------------------------

our $VERSION = '0.037'; # VERSION

#------------------------------------------------------------------------------


has pauserc => (
    is         => 'ro',
    isa        => File,
    lazy       => 1,
    coerce     => 1,
    builder    => '_build_pauserc',
);


#------------------------------------------------------------------------------


has pausecfg => (
    is        => 'ro',
    isa       => HashRef,
    lazy      => 1,
    init_arg  => undef,
    builder   => '_build_pausecfg',
);


#------------------------------------------------------------------------------

sub _build_pauserc {
    my ($self) = @_;

    return file(File::HomeDir->my_home, '.pause');
}

#------------------------------------------------------------------------------

sub _build_pausecfg {
    my ($self) = @_;

    my $cfg = {};
    return $cfg if not -e $self->pauserc();
    my $fh = $self->pauserc->openr();

    # basically taken from the parsing code used by cpan-upload
    # (maybe this should be part of the CPAN::Uploader api?)

    while (<$fh>) {
        next if /^ \s* (?: [#].*)? $/x;
        my ($k, $v) = /^ \s* (\w+) \s+ (.+) $/x;
        $cfg->{$k} = $v;
    }

    return $cfg;
}

#------------------------------------------------------------------------------
1;




=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems pauserc

=head1 NAME

Pinto::Role::Attribute::pausecfg - Something that has a pause config attribute

=head1 VERSION

version 0.037

=head1 ATTRIBUTES

=head2 pauserc

The path to your PAUSE config file.  By default, this is F<~/.pause>.

=head1 METHODS

=head2 pausecfg()

Returns a hashref representing the data of the PAUSE config file.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
