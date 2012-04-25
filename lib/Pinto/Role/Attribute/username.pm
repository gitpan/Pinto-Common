# ABSTRACT: Something that has a username attribute

package Pinto::Role::Attribute::username;

use Moose::Role;

use MooseX::Types::Moose qw(Str);

use Carp;

#------------------------------------------------------------------------------

our $VERSION = '0.038'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Meta::Attribute::Trait::Postable );

#------------------------------------------------------------------------------

has username => (
    is         => 'ro',
    isa        => Str,
    lazy       => 1,
    builder    => '_build_username',
    traits     => [ qw(Postable) ],
);

#------------------------------------------------------------------------------

sub _build_username {
    my ($self) = @_;

    # Look at typical environment variables
    for my $env_var ( qw(USER USERNAME LOGNAME) ) {
        return $ENV{$env_var} if $ENV{$env_var};
    }

    # Try using pwent.  Probably only works on *nix
    if (my $name = getpwuid($<)) {
        return uc $name;
    }

    # Otherwise, we are hosed!
    confess 'Unable to determine your username';

}

#------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Attribute::username - Something that has a username attribute

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

