# ABSTRACT: Something that has a distribution archive attribute

package Pinto::Role::Attribute::archive;

use Moose::Role;

use Pinto::Types qw( File );

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.037'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Meta::Attribute::Trait::Postable );

#------------------------------------------------------------------------------
# Attributes

has archive  => (
    is       => 'ro',
    isa      => File,
    coerce   => 1,
    required => 1,
    traits   => [ qw(Postable) ],
    post_via => sub { [ $_[0]->archive->stringify ] },
);

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Attribute::archive - Something that has a distribution archive attribute

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
