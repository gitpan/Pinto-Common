# ABSTRACT: Specifies a distribution by author and path fragments

package Pinto::DistributionSpec;

use Moose;

use MooseX::Types::Moose qw(ArrayRef Str);
use Pinto::Types qw(AuthorID);

use overload ('""' => 'to_string');

#------------------------------------------------------------------------------

our $VERSION = '0.040_001'; # VERSION

#------------------------------------------------------------------------------

has author => (
    is       => 'ro',
    isa      => AuthorID,
    coerce   => 1,
    required => 1,
);


has basename => (
    is       => 'ro',
    isa      => Str,
    required => 1,
);


has subdirs => (
    is      => 'ro',
    isa     => ArrayRef[Str],
    default => sub { [] },
);

#------------------------------------------------------------------------------

around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;

    my @args = @_;
    if (@args == 1 and not ref $args[0]) {
        my @path_parts = split m{/+}x, $args[0];

        my $author   = shift @path_parts;  # First element
        my $basename = pop @path_parts;    # Last element
        my $subdirs  = [ @path_parts ];    # Everything else

        confess "Invalid distribution spec: $args[0]"
            if not ($author and $basename);

        @args = (author => $author, subdirs => $subdirs, basename => $basename);
    }

    return $class->$orig(@args);
};


#------------------------------------------------------------------------------


sub path {
    my ($self) = @_;

    my $author   = $self->author;
    my @subdirs  = @{ $self->subdirs };
    my $basename = $self->basename;

    return join '/', substr($author, 0, 1),
                     substr($author, 0, 2),
                     $author,
                     @subdirs,
                     $basename;
}

#------------------------------------------------------------------------------


sub to_string {
    my ($self) = @_;

    my $author   = $self->author;
    my @subdirs  = @{ $self->subdirs };
    my $basename = $self->basename;

    return join '/', $author,
                     @subdirs,
                     $basename;
}

#------------------------------------------------------------------------------

__PACKAGE__->meta->make_immutable;

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::DistributionSpec - Specifies a distribution by author and path fragments

=head1 VERSION

version 0.040_001

=head1 METHODS

=head2 path()

Returns the canonical string form of this DistributionSpec, which is
suitable for constructing a URI.

=head2 to_string

This method is called when the DistributionSpec is evaluated in string
context.  Returns the same result as the C<path> method.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
