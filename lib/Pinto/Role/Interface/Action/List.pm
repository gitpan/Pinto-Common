# ABSTRACT: Interface for Action::List

package Pinto::Role::Interface::Action::List;

use Moose::Role;
use MooseX::Types::Moose qw(Str Bool);

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.040_002'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Role::Interface::Action
         Pinto::Role::Attribute::out
         Pinto::Role::Attribute::stack );

#------------------------------------------------------------------------------

has format => (
    is        => 'ro',
    isa       => Str,
    default   => "%m%s%y %-40n %12v  %p\n",
    predicate => 'has_format',
    lazy      => 1,
);


has pinned => (
    is     => 'ro',
    isa    => Bool,
);


has packages => (
    is     => 'ro',
    isa    => Str,
);


has distributions => (
    is     => 'ro',
    isa    => Str,
);

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Interface::Action::List - Interface for Action::List

=head1 VERSION

version 0.040_002

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
