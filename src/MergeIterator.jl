module MergeIterator

import Base: start, next, done, eltype, length

export merge_iterator

type ForwardIterator{S,T}
    state::S
    done::Bool
    elem::T
    function ForwardIterator(it,s)
        m = new(s)
        m.done = done(it,m.state)
        if !m.done
            m.elem,m.state = next(it,m.state)
        end
        m
    end
end

function advance(it,m)
    m.done = done(it,m.state)
    if !m.done
        m.elem,m.state = next(it,m.state)
    end
end

function forward_start(it)
    state = start(it)
    ForwardIterator{typeof(state),eltype(it)}(it,state)
end

immutable Merge
    xss::Vector{Any}
    function Merge(xss...)
        new(Any[xss...])
    end
end

type MergeState
    mss::Vector{Any}
    MergeState(m) = new([forward_start(i) for i in m.xss])
end

eltype(it::Merge) = eltype(it.xss[1])

merge_iterator(xss...) = Merge(xss...)

start(it::Merge) = MergeState(it)

function next(it::Merge,m)
    mini = 0
    minx = 0
    for i = 1:length(m.mss)
        if !m.mss[i].done
            if mini == 0 || minx > m.mss[i].elem
                mini = i
                minx = m.mss[i].elem
            end
        end
    end
    advance(it.xss[mini],m.mss[mini])
    return minx, m
end

function done(it::Merge,m)
    for i = 1:length(m.mss)
        if !m.mss[i].done
            return false
        end
    end
    return true
end

end
