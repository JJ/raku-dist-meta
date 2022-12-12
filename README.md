# Dist::META

The main intention of this module is to offer an uniform API for data that
 might be spread over different keys in the
 [`META6.json` file](https://docs.raku.org/language/modules#index-entry-META6.json-META6.json).

This initial version, however, will focus on getting dependencies right, in a
 single array.
 
## Installing

The usual 

    zef install Dist::META

## Running

`Dist::META` subclasses [`META6`](https://github.com/jonathanstowe/META6
); please check out that distribution for its common API. It adds a class
 attribute, `.dependencies`. Over this META6.json
 
```json
{
  "name" : "JSON::Marshal",
  "tags" : [ "object", "serialisation", "JSON" ],
  "authors" : [ "Jonathan Stowe <jns+git@gellyfish.co.uk>" ],
  "author" : "Jonathan Stowe <jns+git@gellyfish.co.uk>",
  "auth" : "github:jonathanstowe",
  "support" : {
    "source" : "git://github.com/jonathanstowe/JSON-Marshal.git"
  },
  "source-url" : "git://github.com/jonathanstowe/JSON-Marshal.git",
  "perl" : "6",
  "build-depends" : [ ],
  "provides" : {
     "JSON::Marshal" : "lib/JSON/Marshal.pm"
  },
  "depends" : [ "JSON::Tiny" ],
  "test-depends" : [
    "Test"
  ],
  "description" : "Simple serialisation of objects to JSON",
  "version" : "0.0.1"
}
```

You can run this program

```raku
use Dist::META;
my $obj = Dist::META.new(file => $meta-path); # Use path to above file
say $obj.dependencies[0]; # Prints JSON::Tiny
say $obj.dependencies[0].DependencyType; # RUNTIMEDEP
say $obj.dependencies[1].DependencyType; # TESTDEP;
```

`.dependencies` is an array with all dependencies, "tagged" (using mix-ins
) with `RUNTIMEDEP`,`BUILDDEP` or `TESTDEP`, depending on where they have
 been defined (independently of the META6.json key they have used).

## See also

[Test::META](https://github.com/jonathanstowe/Test-META/) tests that
 specifications are correct. [`Pakku::Spec`](https://github.com/hythm7/Pakku-Spec), part of the Pakku package manager, also contains a parser for
 `META6.json` that is closer to the current spec.
 
## License
 
This module will be licensed under the Artistic 2.0 License.
