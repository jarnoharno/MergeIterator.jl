# MergeIterator

[![Build Status](https://travis-ci.org/jlep/MergeIterator.jl.svg?branch=master)](https://travis-ci.org/jlep/MergeIterator.jl)

An iterator that merges multiple oredered iterators over to a single ordered iterator. Similar to [std::merge](http://en.cppreference.com/w/cpp/algorithm/merge) in C++.

## Installation

Install this package with `Pkg.add("https://github.com/jlep/MergeIterator.jl")`

## Usage

- **merge_iterator**(xs...)

    Merge ordered iterators into a single ordered iterator.

    Example:
    ```julia
    for i in merge_iterator([1,3,4], [2,5])
        @show i
    end
    ```

    ```
    i = 1
    i = 2
    i = 3
    i = 4
    i = 5
    ```
