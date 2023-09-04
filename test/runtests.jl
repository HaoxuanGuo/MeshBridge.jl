using MeshBridge
using MeshIO
using FileIO
using Meshes
using GeometryBasics: GeometryBasics
using Test

@testset "MeshBridge" begin
    old_mesh = load("assets/bunny.stl")  # This file is not in package. Just for sample.
    new_mesh = convert(Mesh, old_mesh)
    convert_back_mesh = convert(GeometryBasics.Mesh, new_mesh)

    @test new_mesh isa Mesh
    @test convert_back_mesh isa GeometryBasics.Mesh

    old_triangle = old_mesh[1]
    new_triangle = convert(Triangle, old_triangle)
    convert_back_triangle = convert(GeometryBasics.Triangle, new_triangle)

    @test new_triangle isa Triangle
    @test convert_back_triangle isa GeometryBasics.Triangle

    old_point = old_triangle[1]
    new_point = convert(Point, old_point)
    convert_back_point = convert(GeometryBasics.Point, new_point)

    @test new_point isa Point
    @test convert_back_point isa GeometryBasics.Point
end
