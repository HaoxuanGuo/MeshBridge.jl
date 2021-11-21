module MeshBridge

using Meshes: Meshes
using GeometryBasics: GeometryBasics

function Base.convert(::Type{Meshes.Mesh}, mesh::GeometryBasics.Mesh)
    vertexToIdx = Dict()
    for i in 1:length(mesh.position)
        vertex = mesh.position[i]
        if haskey(vertexToIdx, vertex)
            continue
        end
        vertexToIdx[vertex] = i
    end
    faces = []
    for triangle in mesh
        i1 = vertexToIdx[triangle[1]]
        i2 = vertexToIdx[triangle[2]]
        i3 = vertexToIdx[triangle[3]]
        push!(faces, (i1, i2, i3))
    end
    topology = Meshes.FullTopology(Meshes.connect.(faces))
    result = Meshes.SimpleMesh(
        [Meshes.Point([x[1], x[2], x[3]]) for x in mesh.position], topology
    )
    return result
end

function Base.convert(::Type{GeometryBasics.Mesh}, mesh::Meshes.Mesh)
    return GeometryBasics.Mesh(
        convert.(GeometryBasics.Point, mesh.points),
        [
            GeometryBasics.TriangleFace(x.indices) for
            x in (Meshes.collect(Meshes.elements(Meshes.topology(mesh))))
        ],
    )
end

function Base.convert(::Type{GeometryBasics.Triangle}, triangle::Meshes.Triangle)
    return GeometryBasics.Triangle(convert.(GeometryBasics.Point, triangle.vertices)...)
end

function Base.convert(::Type{Meshes.Triangle}, triangle::GeometryBasics.Triangle)
    return Meshes.Triangle(convert.(Meshes.Point, triangle.points))
end

function Base.convert(::Type{GeometryBasics.Point}, point::Meshes.Point)
    return GeometryBasics.Point(Meshes.coordinates(point))
end

function Base.convert(::Type{Meshes.Point}, point::GeometryBasics.Point)
    return Meshes.Point(point.data)
end

end
