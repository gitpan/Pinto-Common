
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "Module::Build" => "0.3601"
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Common libraries for the L<Pinto> suite",
  "dist_author" => [
    "Jeffrey Ryan Thalhammer <jeff\@stratopan.com>"
  ],
  "dist_name" => "Pinto-Common",
  "dist_version" => "0.070",
  "license" => "perl",
  "module_name" => "Pinto::Common",
  "recommends" => {},
  "recursive_test_files" => 1,
  "requires" => {
    "Carp" => 0,
    "Class::Load" => 0,
    "DateTime" => 0,
    "Digest::MD5" => 0,
    "Digest::SHA" => 0,
    "English" => 0,
    "Exporter" => 0,
    "File::HomeDir" => 0,
    "IO::File" => 0,
    "IO::Handle" => 0,
    "IO::Interactive" => 0,
    "IO::String" => 0,
    "Module::CoreList" => "2.85",
    "Moose" => 0,
    "Moose::Role" => 0,
    "MooseX::MarkAsMethods" => 0,
    "MooseX::Types" => 0,
    "MooseX::Types::Moose" => 0,
    "Path::Class" => 0,
    "Path::Class::Dir" => 0,
    "Path::Class::File" => 0,
    "Readonly" => 0,
    "Scalar::Util" => 0,
    "Throwable::Error" => 0,
    "URI" => 0,
    "UUID::Tiny" => 0,
    "base" => 0,
    "namespace::autoclean" => 0,
    "overload" => 0,
    "perl" => "5.008",
    "strict" => 0,
    "version" => 0,
    "warnings" => 0
  },
  "script_files" => [],
  "test_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "FindBin" => 0,
    "Test::Exception" => 0,
    "Test::More" => 0,
    "Test::Warn" => 0
  }
);


unless ( eval { Module::Build->VERSION(0.4004) } ) {
  my $tr = delete $module_build_args{test_requires};
  my $br = $module_build_args{build_requires};
  for my $mod ( keys %$tr ) {
    if ( exists $br->{$mod} ) {
      $br->{$mod} = $tr->{$mod} if $tr->{$mod} > $br->{$mod};
    }
    else {
      $br->{$mod} = $tr->{$mod};
    }
  }
}

my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
