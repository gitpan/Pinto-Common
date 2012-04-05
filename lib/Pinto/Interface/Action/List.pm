# ABSTRACT: Interface for Action::List

package Pinto::Interface::Action::List;

use Moose::Role;

use MooseX::Types::Moose qw(Maybe Str Bool HashRef);

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.035'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Attribute::out
         Pinto::Meta::Attribute::Trait::Postable );

#------------------------------------------------------------------------------

has format => (
    is      => 'ro',
    isa     => Str,
    traits  => [ qw(Postable) ],
);


has pinned => (
    is     => 'ro',
    isa    => Bool,
    traits => [ qw(Postable) ],
);


has index => (
    is     => 'ro',
    isa    => Str,
    traits => [ qw(Postable) ],
);


has packages => (
    is     => 'ro',
    isa    => Str,
    traits => [ qw(Postable) ],
);


has distributions => (
    is     => 'ro',
    isa    => Str,
    traits => [ qw(Postable) ],
);


has where => (
    is      => 'ro',
    isa     => HashRef,
    builder => '_build_where',
    lazy    => 1,
);

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Interface::Action::List - Interface for Action::List

=head1 VERSION

version 0.035

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
