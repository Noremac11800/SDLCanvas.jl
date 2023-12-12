module InitSDLCanvasTemplate

export create_template

function create_template(path, filename="template.jl")
    @show path
    cp(joinpath(dirname(dirname(@__DIR__)), "examples/SDLCanvas_template.jl"), joinpath(path, filename))
end

end