using MergeIterator
using Base.Test

# write your own tests here
@test collect(merge_iterator([1,3,4,6],[2,5,7])) == [1,2,3,4,5,6,7]
