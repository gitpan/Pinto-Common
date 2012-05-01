#!perl

# This test is generated by Dist::Zilla::Plugin::Test::PodSpelling

use Test::More;

eval "use Pod::Wordlist::hanekomu";
plan skip_all => "Pod::Wordlist::hanekomu required for testing POD spelling"
  if $@;

eval "use Test::Spelling 0.12";
plan skip_all => "Test::Spelling 0.12 required for testing POD spelling"
  if $@;

set_spell_cmd('aspell list');
add_stopwords(<DATA>);
all_pod_files_spelling_ok('bin', 'lib');
__DATA__
PASSed
VCS
Jeffrey
Ryan
Thalhammer
Imaginative
Software
Systems
lib
Pinto
Role
Attribute
author
Meta
Trait
Postable
Interface
Action
Stack
Log
Nop
out
archives
Copy
Statistics
norecurse
Unpin
description
targets
Create
pin
Remove
Pin
Manual
Constants
stack
username
Add
pausecfg
Verify
Edit
Common
List
Pull
DistributionSpec
PackageSpec
Props
Types

