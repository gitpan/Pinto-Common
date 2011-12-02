package Pinto::Constants;

# ABSTRACT: Constants used across the Pinto utilities

use strict;
use warnings;

use Readonly;

use base 'Exporter';

#------------------------------------------------------------------------------

our $VERSION = '0.020'; # VERSION

#------------------------------------------------------------------------------

Readonly our @EXPORT_OK => qw(
    @PINTO_LIST_TYPES
    $PINTO_LIST_TYPES_STRING
    $PINTO_DEFAULT_LIST_TYPE
    $PINTO_ACTION_TYPE_ADD
    $PINTO_ACTION_TYPE_CLEAN
    $PINTO_ACTION_TYPE_LIST
    $PINTO_ACTION_TYPE_NOP
    $PINTO_ACTION_TYPE_REBUILD
    $PINTO_ACTION_TYPE_REMOVE
    $PINTO_ACTION_TYPE_UPDATE
    $PINTO_ACTION_TYPE_VERIFY
);

#------------------------------------------------------------------------------

Readonly our %EXPORT_TAGS => ( 
    list   => [ qw ( @PINTO_LIST_TYPES
                     $PINTO_LIST_TYPES_STRING
                     $PINTO_DEFAULT_LIST_TYPE ) ],

    action => [ qw(  $PINTO_LIST_TYPES_STRING
                     $PINTO_DEFAULT_LIST_TYPE
                     $PINTO_ACTION_TYPE_ADD
                     $PINTO_ACTION_TYPE_CLEAN
                     $PINTO_ACTION_TYPE_LIST
                     $PINTO_ACTION_TYPE_NOP
                     $PINTO_ACTION_TYPE_REBUILD
                     $PINTO_ACTION_TYPE_REMOVE
                     $PINTO_ACTION_TYPE_UPDATE
                     $PINTO_ACTION_TYPE_VERIFY ) ],
);

#------------------------------------------------------------------------------

Readonly our @PINTO_LIST_TYPES => qw(local foreign conflicts all);
Readonly our $PINTO_LIST_TYPES_STRING => join ' | ', sort @PINTO_LIST_TYPES;
Readonly our $PINTO_DEFAULT_LIST_TYPE => 'all';

#------------------------------------------------------------------------------

Readonly our $PINTO_ACTION_TYPE_ADD     => 'Add';
Readonly our $PINTO_ACTION_TYPE_CLEAN   => 'Clean';
Readonly our $PINTO_ACTION_TYPE_LIST    => 'List';
Readonly our $PINTO_ACTION_TYPE_NOP     => 'Nop';
Readonly our $PINTO_ACTION_TYPE_REBUILD => 'Rebuild';
Readonly our $PINTO_ACTION_TYPE_REMOVE  => 'Remove';
Readonly our $PINTO_ACTION_TYPE_UPDATE  => 'Update';
Readonly our $PINTO_ACTION_TYPE_VERIFY  => 'Verify';

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Constants - Constants used across the Pinto utilities

=head1 VERSION

version 0.020

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
