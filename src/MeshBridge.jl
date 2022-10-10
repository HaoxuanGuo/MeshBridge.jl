module MeshBridge

using Meshes: Meshes
using GeometryBasics: GeometryBasics

function Base.convert(::Type{Meshes.Mesh}, mesh::GeometryBasics.Mesh)
    points = [Tuple(p) for p in Set(mesh.position)]
	indices = Dict(p => i for (i, p) in enumerate(points))
	connectivities = map(mesh) do el
		Meshes.connect(Tuple(indices[Tuple(p)] for p in el))
	end
	return Meshes.SimpleMesh(points, connectivities)
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
