use Test;

use Dist::META;

my IO::Path $data-dir = $*PROGRAM.parent.add("data");

my IO::Path $meta-path = $data-dir.add('META6.json');

my $obj;

lives-ok { $obj = Dist::META.new(file => $meta-path) }, "default test";

say $obj.dependencies;
ok $obj.dependencies, "Gathers dependencies";
is $obj.dependencies.elems, 2,  "Correct number of same";

done-testing;
