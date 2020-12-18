"""
# module Conditions



# Examples

```jldoctest
julia>
```
"""
module Conditions

using Compat: @NamedTuple

export InitialCondition, BoundaryCondition

const InitialCondition = @NamedTuple begin
    y0
    y′0
end
const BoundaryCondition = @NamedTuple begin
    y0
    y1
end

end
