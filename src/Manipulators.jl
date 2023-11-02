module Manipulators

export @auto_import

"""
    @auto_import [package_names...]

Import packages of the package names in the given Vector.

# Examples
```julia-repl
julia> @auto_import ["Dates", "DataFrames"]
```
is the equivalent of
```julia-repl
julia> import Dates
julia> import DataFrames
```
"""
macro auto_import(packages)
    t=quote
        exp=Expr(:block)
        exp.args=[:(import $(Symbol(package))) for package in $(esc(packages))]
        exp
    end
    :((@__MODULE__).eval($(t)))
end

"""
Enable using dot syntax to call a function, in a format like x.method(args...)=method(x, args...).
Meant to be used for types that have functions with self has its first argument, just like in OOP languages.
Beware that it's just an alternate syntax, and not an actual support for OOP.
# Examples 
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
"""
macro enable_dot(type)
    t=quote
        function Base.getproperty(obj::$(esc(type)), sym::Symbol)
            if !in(sym, propertynames(obj))
                return (args...)->((@__MODULE__).eval(sym))(obj, args...)
            else
                return getfield(obj, sym)
            end
        end
    end
    return t
end
end # module Manipulators
