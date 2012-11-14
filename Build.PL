
use strict;
use warnings;

use Module::Build 0.3601;


my %module_build_args = (
  "build_requires" => {
    "File::Find" => 0,
    "File::Temp" => 0,
    "FindBin" => 0,
    "Module::Build" => "0.3601",
    "Test::Exception" => 0,
    "Test::More" => 0,
    "Test::Warn" => 0
  },
  "configure_requires" => {
    "Module::Build" => "0.3601"
  },
  "dist_abstract" => "Common libraries for the L<Pinto> suite",
  "dist_author" => [
    "Jeffrey Ryan Thalhammer <jeff\@imaginative-software.com>"
  ],
  "dist_name" => "Pinto-Common",
  "dist_version" => "0.064",
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
    "Exporter" => 0,
    "File::HomeDir" => 0,
    "IO::File" => 0,
    "IO::Handle" => 0,
    "IO::Interactive" => 0,
    "IO::String" => 0,
    "Moose" => 0,
    "Moose::Exporter" => 0,
    "Moose::Role" => 0,
    "MooseX::Types" => 0,
    "MooseX::Types::Moose" => 0,
    "Path::Class" => 0,
    "Path::Class::Dir" => 0,
    "Path::Class::File" => 0,
    "Readonly" => 0,
    "Scalar::Util" => 0,
    "Throwable::Error" => 0,
    "Try::Tiny" => 0,
    "URI" => 0,
    "base" => 0,
    "namespace::autoclean" => 0,
    "overload" => 0,
    "perl" => "5.008",
    "strict" => 0,
    "version" => 0,
    "warnings" => 0
  },
  "script_files" => []
);


my $build = Module::Build->new(%module_build_args);

$build->create_build_script;
