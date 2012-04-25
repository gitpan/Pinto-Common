# ABSTRACT: Something that has a target attribute

package Pinto::Role::Attribute::target;

use Moose::Role;

use Pinto::PackageSpec;
use Pinto::DistributionSpec;

use namespace::autoclean;

#------------------------------------------------------------------------------

our $VERSION = '0.038'; # VERSION

#------------------------------------------------------------------------------

with qw( Pinto::Meta::Attribute::Trait::Postable );

#------------------------------------------------------------------------------

has target => (
    is       => 'ro',
    isa      => 'Pinto::PackageSpec | Pinto::DistributionSpec',
    traits   => [ qw(Postable) ],
    post_via => sub { $_[0]->target->to_string },
    required => 1,
);

#------------------------------------------------------------------------------

around BUILDARGS => sub {
    my $orig = shift;
    my $class = shift;
    my %args = @_;

    # If the target is not a reference, then we presume it is a
    # specification string.  If the string contains a slash then it
    # must be a DistributionSpec.  Otherwise it must be a PackageSpec.

    if ($args{target} and not ref $args{target}) {
        my $target = delete $args{target};
        $args{target} = $target =~ m{/}x ? Pinto::DistributionSpec->new($target)
                                         : Pinto::PackageSpec->new($target);
    }

    return $class->$orig(%args);
};

#------------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Role::Attribute::target - Something that has a target attribute

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
