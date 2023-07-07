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

end # module Manipulators
