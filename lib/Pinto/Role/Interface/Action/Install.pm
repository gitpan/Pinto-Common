# ABSTRACT: Interface for Action::Install

package Pinto::Role::Interface::Action::Install;

use Moose::Role;
use MooseX::Types::Moose qw(HashRef ArrayRef Maybe Str);

use File::Which qw(which);

use Pinto::Exception qw(throw);

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.040_002'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Role::Interface::Action );

#------------------------------------------------------------------------------

has cpanm_options => (
    is      => 'ro',
    isa     => HashRef[Maybe[Str]],
    default => sub { {} },
    lazy    => 1,
);


has cpanm_exe => (
    is      => 'ro',
    isa     => Str,
    default => sub { which('cpanm') || '' },
    lazy    => 1,
);


has stack   => (
    is      => 'ro',
    isa     => Str,
);


has targets => (
    is      => 'ro',
    isa     => ArrayRef[Str],
    default => sub { [] },
    lazy    => 1,
);

#------------------------------------------------------------------------------

sub BUILD {}

before BUILD => sub {
    my ($self, @args) = @_;

    my $cpanm_exe = $self->cpanm_exe
      or throw 'Must have cpanm to do install';

    my $cpanm_version_cmd = "$cpanm_exe --version";
    my $cpanm_version_cmd_output = qx{$cpanm_version_cmd};  ## no critic qw(Backtick)
    throw "Could not learn version of cpanm: $!" if $?;

    my ($cpanm_version) = $cpanm_version_cmd_output =~ m{version \s+ ([\d.]+)}x
      or throw "Could not parse cpanm version number from $cpanm_version_cmd_output";

    my $min_cpanm_version = '1.500';
    if ($cpanm_version < $min_cpanm_version) {
      throw "Your cpanm ($cpanm_version) is too old.  Must have ($min_cpanm_version) or newer";
    }

    return $self;
};

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Interface::Action::Install - Interface for Action::Install

=head1 VERSION

version 0.040_002

=for Pod::Coverage BUILD

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


