# Why This Package

Because there are two packages about geometry

- [Meshes.jl](https://github.com/JuliaGeometry/Meshes.jl) - the future geometry package.
- [GeometryBasics.jl](https://github.com/JuliaGeometry/GeometryBasics.jl) - the current main geometry package.

These two are not compatible now. This package is use to convert types between these two packages.

Thanks [Felipe Kersting](https://github.com/felipeek) write the [code](https://github.com/JuliaIO/MeshIO.jl/issues/67) and [Manuel Schmid](https://github.com/mfsch) write the [code](https://github.com/JuliaIO/MeshIO.jl/issues/67#issuecomment-1268931642) from `GeometryBasics.Mesh` to `Meshes.Mesh`.

**NOTE: YOU SHOULD NOT USE BOTH TWO PACKAGE IN YOUR CODE. BECAUSE THE CONVERSION IS VERY SLOW. IT IS JUST WORK WITH OUT ANY PERFORMANCE.**

# How to Use This Package

Via `convert` method.

```julia
using MeshIO
using FileIO
using Meshes
using GeometryBasics: GeometryBasics

old_mesh = load("bunny.stl")  # This file is not in package. Just for sample.
new_mesh = convert(Mesh, old_mesh)
convert_back_mesh = convert(GeometryBasics.Mesh, new_mesh)

old_triangle = old_mesh[1]
new_triangle = convert(Triangle, old_triangle)
convert_back_triangle = convert(GeometryBasics.Triangle, new_triangle)

old_point = old_triangle[1]
new_point = convert(Point, old_point)
convert_back_point = convert(GeometryBasics.Point, new_point)
```

note: `using` two packages at the same time will get conflict. Just import the one you use in your inner code.

```julia
using GeometryBasics
using Meshes  # Get conflict here.
```

The above will get conflict. Use the below code.

```julia
using GeometryBasics: GeometryBasics    # The one just for compatible
using Meshes                            # The one real used
```
