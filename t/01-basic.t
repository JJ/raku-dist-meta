use Test;

use Dist::META;

my IO::Path $data-dir = $*PROGRAM.parent.add("data");

my IO::Path $meta-path = $data-dir.add('META6.json');

my $obj;

lives-ok { $obj = Dist::META.new(file => $meta-path) }, "default test";

ok $obj.dependencies, "Gathers dependencies";
is $obj.dependencies.elems, 2,  "Correct number of same";
is $obj.dependencies[0].DependencyType, RUNTIMEDEP,
        "Dependency default type assigned correctly";
is $obj.dependencies[1].DependencyType, TESTDEP,
        "Dependency type test assigned correctly";

$meta-path = $data-dir.add('META6-inline-python.json');
say $meta-path;
lives-ok { $obj = Dist::META.new(file => $meta-path) }, "another test";

is $obj.dependencies.elems, 1,  "Correct number of same";
is $obj.dependencies.first.DependencyType, RUNTIMEDEP,
        "Dependency default type assigned correctly";
done-testing;
