# ABSTRACT: Specifies a package by name and version

package Pinto::PackageSpec;

use Moose;

use MooseX::Types::Moose qw(Str);
use Pinto::Types qw(Vers);

use overload ('""' => 'to_string');

#------------------------------------------------------------------------------

our $VERSION = '0.048'; # VERSION

#------------------------------------------------------------------------------

has name => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);


has version => (
    is      => 'ro',
    isa     => Vers,
    coerce  => 1,
    default => sub { version->parse(0) }
);

#------------------------------------------------------------------------------

around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;

    my @args = @_;
    if (@args == 1 and not ref $args[0]) {
        my ($name, $version) = split m{~}x, $_[0], 2;
        @args = (name => $name, version => $version || 0);
    }

    return $class->$orig(@args);
};

#------------------------------------------------------------------------------


sub to_string {
    my ($self) = @_;
    return sprintf '%s~%s', $self->name, $self->version->stringify;
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable;

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::PackageSpec - Specifies a package by name and version

=head1 VERSION

version 0.048

=head1 METHODS

=head2 to_string()

Serializes this PackageSpec to its string form.  This method is called
whenever the PackageSpec is evaluated in string context.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

