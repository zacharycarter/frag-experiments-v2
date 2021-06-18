# Package

version       = "0.1.0"
author        = "carterza"
description   = "A new awesome nimble package"
license       = "BSD-3-Clause"
srcDir        = "src"
installExt    = @["nim"]
bin           = @["frag"]


# Dependencies

requires "nim >= 1.4.8"
requires "ptr_math >= 0.3.0"
requires "winim >= 3.6.1"