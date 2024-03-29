use Test;

use Dist::META;

my IO::Path $data-dir = $*PROGRAM.parent.add("data");

my IO::Path $meta-path = $data-dir.add('META6.json');

my $obj;

lives-ok { $obj = Dist::META.new(file => $meta-path) }, "default test";

ok $obj.dependencies, "Gathers dependencies for META6.json";
is $obj.dependencies.elems, 2,  "Correct number of dependencies in META6.json";
for $obj.dependencies -> $d {
    state @deps = <JSON::Tiny Test>;
    isa-ok $d, Str, "Dependency is a Str";
    is $d, (shift @deps), "Dependency $d is correct";
}
is $obj.dependencies[0].DependencyType, RUNTIMEDEP,
        "Dependency default type assigned correctly";
is $obj.dependencies[1].DependencyType, TESTDEP,
        "Dependency type test assigned correctly";

$meta-path = $data-dir.add('META6-inline-python.json');
lives-ok { $obj = Dist::META.new(file => $meta-path) },
        "Another test with Inline::Python";

is $obj.dependencies.elems, 2,  "Correct number of same";
is $obj.dependencies.first.DependencyType, BUILDDEP,
        "Dependency default type assigned correctly for Inline::Python META6";

$meta-path = $data-dir.add('META6-inline-perl.json');
lives-ok { $obj = Dist::META.new(file => $meta-path) }, "another test";
is $obj.dependencies.elems, 4,  "Correct number of same";
is $obj.dependencies.first.DependencyType, BUILDDEP,
        "Dependency default type assigned correctly";
is $obj.dependencies[2].DependencyType, RUNTIMEDEP,
        "Dependency default type assigned correctly";

$meta-path = $data-dir.add('nodepends.json');
lives-ok { $obj = Dist::META.new(file => $meta-path) }, "default test";
nok $obj.dependencies, "No dependencies, no error either";

my %phases = $obj.phases-eq();
for ( "build" => BUILDDEP, "runtime" => RUNTIMEDEP, "test" => TESTDEP ) ->
$t-pair {
    is %phases{$t-pair.key}, $t-pair.value, "$t-pair OK";
}


done-testing;
