# ABSTRACT: Something that has an author id attribute

package Pinto::Role::Attribute::author;

use Moose::Role;

use Carp;

use Pinto::Types qw(AuthorID);

#------------------------------------------------------------------------------

our $VERSION = '0.038'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Role::Attribute::pausecfg
         Pinto::Role::Attribute::username
         Pinto::Meta::Attribute::Trait::Postable );

#------------------------------------------------------------------------------

has author => (
    is         => 'ro',
    isa        => AuthorID,
    coerce     => 1,
    lazy       => 1,
    builder    => '_build_author',
    traits     => [ qw(Postable) ],
);

#------------------------------------------------------------------------------

sub _build_author {
    my ($self) = @_;

    # Try looking in their .pause file
    my $pause_id = $self->pausecfg->{user};
    return uc $pause_id if $pause_id;

    # Fall back to username
    return uc $self->username;
}

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Attribute::author - Something that has an author id attribute

=head1 VERSION

version 0.038

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__

