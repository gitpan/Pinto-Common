package Pinto::Types;

# ABSTRACT: Moose types used within Pinto

use strict;
use warnings;

use MooseX::Types -declare => [ qw( AuthorID Uri Dir File IO Vers
                                    Pkg Dist ArrayRefOfFiles ArrayRefOfPkgsOrDists) ];

use MooseX::Types::Moose qw(Str Num ScalarRef ArrayRef HashRef FileHandle Object Int);

use URI;
use Class::Load;
use Path::Class::Dir;
use Path::Class::File;
use File::HomeDir;
use IO::String;
use IO::Handle;
use IO::File;

use version;
use namespace::autoclean;

#-----------------------------------------------------------------------------

our $VERSION = '0.040_001'; # VERSION

#-----------------------------------------------------------------------------

subtype AuthorID,
    as Str,
    where { not m/[^A-Z0-9-]/x },
    message { "The author id ($_) must be alphanumeric" };

coerce AuthorID,
    from Str,
    via  { uc $_ };
#-----------------------------------------------------------------------------

class_type Vers, {class => 'version'};

coerce Vers,
    from Str,
    via { version->parse($_) };

coerce Vers,
    from Num,
    via { version->parse($_) };

#-----------------------------------------------------------------------------

class_type Uri, {class => 'URI'};

coerce Uri,
    from Str,
    via { URI->new($_) };

#-----------------------------------------------------------------------------

class_type Dir, {class => 'Path::Class::Dir'};

coerce Dir,
    from Str,             via { Path::Class::Dir->new($_) },
    from ArrayRef,        via { Path::Class::Dir->new(@{$_}) };

#-----------------------------------------------------------------------------

class_type File, {class => 'Path::Class::File'};

coerce File,
    from Str,             via { Path::Class::File->new($_) },
    from ArrayRef,        via { Path::Class::File->new(@{$_}) };

#-----------------------------------------------------------------------------

subtype ArrayRefOfFiles, as ArrayRef[File];

coerce ArrayRefOfFiles,
  from  File,          via { [ $_ ] },
  from  Str,           via { [ Path::Class::File->new($_) ] },
  from  ArrayRef[Str], via { [ map { Path::Class::File->new($_) } @$_ ] };

#-----------------------------------------------------------------------------

class_type Pkg, {class => 'Pinto::PackageSpec'};

coerce Pkg,
  from Str,     via { _coerce_str_to_spec($_) },
  from HashRef, via { _coeree_str_to_spec($_) };

#-----------------------------------------------------------------------------

class_type Dist, {class => 'Pinto::DistributionSpec'};

coerce Dist,
  from Str,         via { _coerce_str_to_spec($_) },
  from HashRef,     via { _coerce_str_to_spec($_) };


#-----------------------------------------------------------------------------

subtype ArrayRefOfPkgsOrDists,
  as ArrayRef[Pkg | Dist];           ## no critic qw(ProhibitBitwiseOperators);

coerce ArrayRefOfPkgsOrDists,
  from  Pkg,              via { [ $_ ] },
  from  Dist,             via { [ $_ ] },
  from  Str,              via { [ _coerce_str_to_spec($_) ] },
  from  ArrayRef[Str],    via { [ map { _coerce_str_to_spec($_) } @$_ ] };


sub _coerce_str_to_spec {
  my ($str) = @_;

  my $class = ($str =~ m{/}x) ? 'Pinto::DistributionSpec'
                              : 'Pinto::PackageSpec';

  # HACK: This type library needs the DistributionSpec and PackageSpec
  # modules so it can coerce things to those classes.  But those
  # classes depend on this type library to define types for their
  # attributes.  So to avoid this circular dependency, we're going to
  # just defer loading the PackageSpec and DistributionSpec classes
  # until will need them at runtime.

  Class::Load::load_class($class);
  return $class->new($str);
}


#-----------------------------------------------------------------------------

subtype IO, as Object;

coerce IO,
    from Str,        via { my $fh = IO::File->new(); $fh->open($_);   return $fh },
    from File,       via { my $fh = IO::File->new(); $fh->open("$_"); return $fh },
    from ArrayRef,   via { IO::Handle->new_from_fd( @$_ ) },
    from ScalarRef,  via { IO::String->new( ${$_} ) };

#-----------------------------------------------------------------------------

1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Types - Moose types used within Pinto

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
