use Test;

use Dist::META;

my IO::Path $data-dir = $*PROGRAM.parent.add("data");

my IO::Path $meta-path = $data-dir.add('META6.json');

my $obj;

lives-ok { $obj = Dist::META.new(file => $meta-path) }, "default test";

say $obj.raku;
ok $obj.dependencies, "Gathers dependencies";

done-testing;
