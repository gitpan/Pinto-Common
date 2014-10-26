# ABSTRACT: Interface for Action::Add

package Pinto::Interface::Action::Add;

use Moose::Role;

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.035'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Attribute::author
         Pinto::Attribute::archive
         Pinto::Attribute::norecurse );

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Interface::Action::Add - Interface for Action::Add

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
