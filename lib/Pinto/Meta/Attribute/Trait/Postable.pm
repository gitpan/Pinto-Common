# ABSTRACT: Trait for marking attributes as something to POST

package Pinto::Meta::Attribute::Trait::Postable;

use Moose::Role;
use MooseX::Types::Moose qw(Str CodeRef);

use namespace::autoclean;

#-----------------------------------------------------------------------------

our $VERSION = '0.038'; # VERSION

#-----------------------------------------------------------------------------


has post_as => (
    is       => 'ro',
    isa      => Str,
);


has post_via => (
   is        => 'ro',
   isa       => CodeRef,
);

#-----------------------------------------------------------------------------


sub as_post_data {
    my ($self) = @_;

    my @post_data;
    for my $attribute ( $self->meta->get_all_attributes ) {

        next if not $attribute->does( __PACKAGE__ );

        my $key   = $attribute->post_as()  || $attribute->name();
        my $via   = $attribute->post_via() || $attribute->get_read_method();
        my $value = $self->$via();

        next if not defined $value;

        push @post_data, $key, $value;
    }

    return \@post_data;
}

#-----------------------------------------------------------------------------
## no critic qw(ProhibitMultiplePackages)

package # hide from PAUSE
    Moose::Meta::Attribute::Custom::Trait::Postable;

sub register_implementation {return 'Pinto::Meta::Attribute::Trait::Postable'}

#-----------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Meta::Attribute::Trait::Postable - Trait for marking attributes as something to POST

=head1 VERSION

version 0.038

=head1 ATTRIBUTES

=head2 post_as => NAME

Specify an alternative name for the attribute when posting it.
If not specified, the posted attribute name will be the same
as the object attribute name.

=head2 post_via => CODEREF

Specify an alternative subroutine for transforming the attribute value
before posting it.  If not specified, the posted value will be the
same as the attribute value.

=head1 METHODS

=head2 as_post_data()

Returns an array reference containing the names => values of each
C<Postable> attribute of this object.  This array reference is
suitable for passing to the C<POST> function in
L<HTTP::Request::Common> or the C<post> method of L<LWP::UserAgent>.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__
