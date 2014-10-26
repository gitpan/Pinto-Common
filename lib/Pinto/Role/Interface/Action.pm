# ABSTRACT: Base interface for all Actions

package Pinto::Role::Interface::Action;

use Moose::Role;

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.037'; # VERSION

#------------------------------------------------------------------------------

requires qw(execute);

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Interface::Action - Base interface for all Actions

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
