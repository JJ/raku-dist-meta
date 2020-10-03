use Test;

use Dist::META;

is( %phases-eq<build>, BUILDDEP, "Build OK" );
is( %phases-eq<test>, TESTDEP, "Test OK" );
is( %phases-eq<runtime>, RUNTIMEDEP, "Runtime OK" );
done-testing;
