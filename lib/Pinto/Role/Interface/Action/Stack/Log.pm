# ABSTRACT: Interface for Action::Stack::Log

package Pinto::Role::Interface::Action::Stack::Log;

use Moose::Role;
use MooseX::Types::Moose qw(Bool Int);

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.040_001'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Role::Interface::Action
         Pinto::Role::Attribute::stack
         Pinto::Role::Attribute::out );

#------------------------------------------------------------------------------

has revision => (
    is        => 'ro',
    isa       => Int,
    predicate => 'has_revision',
);

has detailed => (
    is      => 'ro',
    isa     => Bool,
    default => 0,
);

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Interface::Action::Stack::Log - Interface for Action::Stack::Log

=head1 VERSION

version 0.040_001

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
