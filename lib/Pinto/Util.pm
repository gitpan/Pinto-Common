package Pinto::Util;

# ABSTRACT: Static utility functions for Pinto

use strict;
use warnings;
use version;

use Carp;
use Try::Tiny;
use Path::Class;
use Digest::MD5;
use Digest::SHA;
use Scalar::Util;
use IO::Interactive;
use DateTime;
use Readonly;

use Pinto::Globals;
use Pinto::Constants qw($PINTO_STACK_NAME_REGEX $PINTO_PROPERTY_NAME_REGEX);
use Pinto::Exception qw(throw);

use namespace::autoclean;

use base qw(Exporter);

#-------------------------------------------------------------------------------

our $VERSION = '0.064'; # VERSION

#-------------------------------------------------------------------------------

Readonly our @EXPORT_OK => qw(
    author_dir
    current_time
    current_user
    is_interactive
    is_vcs_file
    isa_perl
    itis
    md5
    mtime
    sha256
    interpolate
    trim
);

Readonly our %EXPORT_TAGS => ( all => \@EXPORT_OK );

#-------------------------------------------------------------------------------


sub author_dir {                                  ## no critic (ArgUnpacking)
    my $author = uc pop;
    my @base =  @_;

    return dir(@base, substr($author, 0, 1), substr($author, 0, 2), $author);
}

#-------------------------------------------------------------------------------


sub itis {
    my ($var, $class) = @_;

    return ref $var && Scalar::Util::blessed($var) && $var->isa($class);
}

#-------------------------------------------------------------------------------


sub parse_dist_path {
    my ($path) = @_;

    # /yadda/authors/id/A/AU/AUTHOR/subdir1/subdir2/Foo-1.0.tar.gz

    if ( $path =~ s{^ (.*) /authors/id/(.*) $}{$2}mx ) {

        # $path = 'A/AU/AUTHOR/subdir/Foo-1.2.tar.gz'
        my @path_parts = split m{ / }mx, $path;
        my $author  = $path_parts[2];  # AUTHOR
        my $archive = $path_parts[-1]; # Foo-1.0.tar.gz
        return ($author, $archive);
    }
    else {

        confess 'Unable to parse url: $url';
    }

}

#-------------------------------------------------------------------------------


sub isa_perl {
    my ($path_or_url) = @_;

    return $path_or_url =~ m{ / perl-[\d.]+ \.tar \.(?: gz|bz2 ) $ }mx;
}

#-------------------------------------------------------------------------------


Readonly my %VCS_FILES => (map {$_ => 1} qw(.svn .git .gitignore CVS));

sub is_vcs_file {
    my ($file) = @_;

    $file = file($file) unless eval { $file->isa('Path::Class::File') };

    return exists $VCS_FILES{ $file->basename() };
}

#-------------------------------------------------------------------------------


sub mtime {
    my ($file) = @_;

    confess 'Must supply a file' if not $file;
    confess "$file does not exist" if not -e $file;

    return (stat $file)[9];
}

#-------------------------------------------------------------------------------


sub md5 {
    my ($file) = @_;

    confess 'Must supply a file' if not $file;
    confess "$file does not exist" if not -e $file;

    my $fh = $file->openr();
    my $md5 = Digest::MD5->new->addfile($fh)->hexdigest();

    return $md5;
}

#-------------------------------------------------------------------------------


sub sha256 {
    my ($file) = @_;

    confess 'Must supply a file' if not $file;
    confess "$file does not exist" if not -e $file;

    my $fh = $file->openr();
    my $sha256 = Digest::SHA->new(256)->addfile($fh)->hexdigest();

    return $sha256;
}

#-------------------------------------------------------------------------------


sub validate_property_name {
    my ($prop_name) = @_;

    throw "Invalid property name $prop_name" if $prop_name !~ $PINTO_PROPERTY_NAME_REGEX;

    return $prop_name;
}

#-------------------------------------------------------------------------------


sub validate_stack_name {
    my ($stack_name) = @_;

    throw "Invalid stack name $stack_name" if $stack_name !~ $PINTO_STACK_NAME_REGEX;

    return $stack_name;
}

#-------------------------------------------------------------------------------


sub current_time {

    ## no critic qw(PackageVars)
    return $Pinto::Globals::current_time
      if defined $Pinto::Globals::current_time;

    return time;
}

#-------------------------------------------------------------------------------


sub current_user {

    ## no critic qw(PackageVars)
    return $Pinto::Globals::current_user
      if defined $Pinto::Globals::current_user;

    return $ENV{USER} || $ENV{LOGIN} || $ENV{USERNAME} || $ENV{LOGNAME};
}

#-------------------------------------------------------------------------------


sub is_interactive {

    ## no critic qw(PackageVars)
    return $Pinto::Globals::is_interactive
      if defined $Pinto::Globals::is_interactive;

    return IO::Interactive::is_interactive;
}

#-------------------------------------------------------------------------------


sub interpolate {
    my $string = shift;

    return eval qq{"$string"};  ## no critic qw(Eval)
}

#-------------------------------------------------------------------------------


sub trim {
    my $string = shift;

    $string =~ s/^ \s+  //x;
    $string =~ s/  \s+ $//x;

    return $string;
}

#-------------------------------------------------------------------------------
1;



=pod

=for :stopwords Jeffrey Ryan Thalhammer Imaginative Software Systems

=head1 NAME

Pinto::Util - Static utility functions for Pinto

=head1 VERSION

version 0.064

=head1 DESCRIPTION

This is a private module for internal use only.  There is nothing for
you to see here (yet).  All API documentation is purely for my own
reference.

=head1 FUNCTIONS

=head2 author_dir( @base, $author )

Given the name of an C<$author>, returns the directory where the
distributions for that author belong (as a L<Path::Class::Dir>).  The
optional C<@base> can be a series of L<Path::Class:Dir> or path parts
(as strings).  If C<@base> is given, it will be prepended to the
directory that is returned.

=head2 itis( $var, $class )

Asserts whether var is a blessed reference and is an instance of the
C<$class>.

=head2 parse_dist_path( $path )

Parses a path like one would see in the URL to a distribution in a
CPAN repository and returns the author and file name of the
distribution.  Other subdirectories in the path are ignored.

=head2 isa_perl( $path_or_url )

Return true if C<$path_or_url> appears to point to a release of perl
itself.  This is based on some file naming patterns that I've seen in
the wild.  It may not be completely accurate.

=head2 is_vcs_file( $path );

Returns true if C<$path> appears to point to a file that is an
internal part of a VCS system.

=head2 mtime( $file )

Returns the last modification time (in epoch seconds) for the C<file>.
The argument is required and the file must exist or an exception will
be thrown.

=head2 md5( $file )

Returns the C<MD-5> digest (as a hex string) for the C<$file>.  The
argument is required and the file must exist on an exception will be
thrown.

=head2 sha256( $file )

Returns the C<SHA-256> digest (as a hex string) for the C<$file>.  The
argument is required and the file must exist on an exception will be
thrown.

=head2 validate_property_name( $prop_name )

Throws an exception if the property name is invalid.  Currently, property names 
must be alphanumeric plus any underscores or hyphens.

=head2 validate_stack_name( $stack_name )

Throws an exception if the stack name is invalid.  Currently, stack names must 
be alphanumeric plus underscores or hyphens.

=head2 current_time()

Returns the current time (in epoch seconds) unless the current time has been
overridden by C<$Pinto::Globals::current_time>.

=head2 current_user()

Returns the id of the current user unless it has been overridden by
C<$Pinto::Globals::current_user>.

=head2 is_interactive()

Returns true if the process is connected to an interactive terminal
(i.e.  a keyboard & screen) unless it has been overridden by
C<$Pinto::Globals::is_interactive>.

=head2 interpolate($string)

Performs interpolation on a literal string.  The string should not
include anything that looks like a variable.  Only metacharacters
(like \n) will be interpolated correctly.

=head2 trim($string)

Returns the string with all leading and trailing whitespace removed.

=head1 AUTHOR

Jeffrey Ryan Thalhammer <jeff@imaginative-software.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2011 by Imaginative Software Systems.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut


__END__


