# Manipulators.jl
Just some custom julia functions and macros, to make things easier.
---
## Macros
- @auto_import [package_names] : Import packages of given package names in the vector. Don't work for importing local modules, since they require a dot in front of them, and any attempt to bypass it via providing arguments such as ".package_name" wouldn't work.
