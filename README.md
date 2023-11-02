# Manipulators.jl
Just some custom julia functions and macros, to make things easier.
---
## Macros
- **@auto_import [package_names]**   
  Import packages of given package names in the vector. Don't work for importing local modules, since they require a dot in front of them, and any attempt to bypass it via providing arguments such as ".package_name" wouldn't work.  

```julia-repl
julia> @auto_import ["Dates", "DataFrames"]
```
is the equivalent of
```julia-repl
julia> import Dates
julia> import DataFrames
```
- **@enable_dot type** 
  Enable using dot syntax to call a function, in a format like x.method(args...)=method(x, args...). Meant to be used for types that have functions with self has its first argument, just like in OOP languages. Beware that it's just an alternate syntax, and not an actual support for OOP.  
```julia-repl
julia> struct A
           x
           y   
       end
julia> @enable_dot A
julia> addA(x::A)=x.x+x.y
julia> a=A(1,2)
julia> a.addA()
3
```