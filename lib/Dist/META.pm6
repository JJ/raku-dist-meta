use META6;

enum DependencyType <BUILDDEP TESTDEP RUNTIMEDEP>;
constant @phases = <build runtime test>;

constant %phases-eq = Hash.new( @phases Z DependencyType::.values );

unit class Dist::META is META6;

has @.dependencies;
has $.source;

submethod TWEAK() {
    if self.depends ~~ Hash {
        for @phases -> $phase {
            with self.depends{$phase}<requires> -> $phase-requires {
                for $phase-requires<> -> $req {
                    @!dependencies.push: $req but %phases-eq{$phase}
                }
            }
        }
    } elsif self.depends ~~ Array {
        for self.depends -> $req {
            @!dependencies.push: $req but RUNTIMEDEP;
        }
    }
    for self.build-depends -> $req {
        @!dependencies.push: $req but BUILDDEP;
    }
    for self.test-depends -> $req {
        @!dependencies.push: $req but TESTDEP;
    }

}
