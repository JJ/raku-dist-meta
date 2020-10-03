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
say $obj.dependencies[0].DependencyType; # Returns RUNTIMEDEP
say $obj.dependencies[1].DependencyType; # TESTDEP;
```

`.dependencies` is an array with all dependencies, "tagged" (using mix-ins
) with `RUNTIMEDEP`,`BUILDDEP` or `TESTDEP`, depending on where they have been 

## See also

<-- Related stuff -->

## License
<-- 
This module will be licensed, by default, under the Artistic 2.0 License (the same as Raku itself). You can change it by using a different LICENSE file, as well as changing the license field in META6.json -->
