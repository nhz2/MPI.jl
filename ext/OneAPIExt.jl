module OneAPIExt

using oneAPI: oneAPI
using MPI: MPI, MPIPtr, Buffer, Datatype, CConvWrapper

function Base.cconvert(::Type{MPIPtr}, buf::oneAPI.oneArray{T}) where T
    CConvWrapper(oneAPI.ZePtr{T}, buf)
end

function Base.cconvert(::Type{MPIPtr}, buf::SubArray{T,N,P,I,true}) where {T,N,P<:oneAPI.oneArray,I}
    CConvWrapper(oneAPI.ZePtr{T}, buf)
end

function MPI.Buffer(arr::oneAPI.oneArray)
    Buffer(arr, Cint(length(arr)), Datatype(eltype(arr)))
end

end # OneAPIExt
