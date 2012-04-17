# ABSTRACT: Something that has a version attribute

package Pinto::Role::Attribute::version;

use Moose::Role;

use Pinto::Types qw(Vers);

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.037'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Meta::Attribute::Trait::Postable );

#------------------------------------------------------------------------------

has version => (
    is        => 'ro',
    isa       => Vers,
    coerce    => 1,
    predicate => 'has_version',
    traits    => [ qw(Postable) ],
    post_via  => sub { $_[0]->version->stringify },
);

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Attribute::version - Something that has a version attribute

=head1 VERSION

version 0.037

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
