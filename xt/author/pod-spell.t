use strict;
use warnings;
use Test::More;

# generated by Dist::Zilla::Plugin::Test::PodSpelling 2.002005
eval "use Test::Spelling 0.12; use Pod::Wordlist::hanekomu; 1" or die $@;

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
Constants
Common
Manual
Tutorial
QuickStart
SpecFactory
Introduction
DistributionSpec
Globals
PackageSpec
Util
Types
Role
PauseConfig
Exception
