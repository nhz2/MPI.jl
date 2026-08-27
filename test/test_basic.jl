include("common.jl")

@test !MPI.Initialized()
MPI.Init()
@test MPI.Initialized()

@test 0 <= MPI.Comm_rank(MPI.COMM_WORLD) < MPI.Comm_size(MPI.COMM_WORLD)

@test MPI.has_cuda() isa Bool

if get(ENV, "JULIA_MPI_TEST_ARRAYTYPE", "") == "CuArray"
    @test MPI.has_cuda()
end

@test MPI.has_rocm() isa Bool

if get(ENV, "JULIA_MPI_TEST_ARRAYTYPE", "") == "ROCArray"
    @test MPI.has_rocm()
end

@test MPI.has_oneapi() isa Bool

if get(ENV, "JULIA_MPI_TEST_ARRAYTYPE", "") == "oneArray"
    @test MPI.has_oneapi()
end

@test MPI.has_gpu() isa Bool

if get(ENV, "JULIA_MPI_TEST_ARRAYTYPE", "") in ("CuArray", "ROCArray", "oneArray")
    @test MPI.has_gpu()
end

@test !MPI.Finalized()
MPI.Finalize()
@test MPI.Finalized()
