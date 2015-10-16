# distutils: language = c++

##Define the basic iterator types (this is incomplete)
cdef extern from "<iterator>" namespace "std":
    cdef cppclass iterator[Category,T,Distance,Pointer,Reference]:
        pass
    cdef cppclass output_iterator_tag:
        pass
    #The goal here is to get back_inserter working, as it is handy.
    cdef cppclass back_insert_iterator[T](iterator[output_iterator_tag,void,void,void,void]):
        pass
    back_insert_iterator[CONTAINER] back_inserter[CONTAINER](CONTAINER &)

##Not shown here, but I've gotten C++11's move algorithm to work, too,
##using same kind of prototype
cdef extern from "<algorithm>" namespace "std":
    OUTPUT copy[INPUT,OUTPUT](INPUT,INPUT,OUTPUT)

from libcpp.vector cimport vector
from libcpp.string cimport string

ctypedef vector[string].iterator vstr_itr
ctypedef back_insert_iterator[vector[string]] back_insert_itr

def testit():
    cdef vector[string] foo
    cdef vector[string] foo2

    cdef char * blah = "abcd"
    cdef char * blah2 = "dcba"

    foo.push_back(string(blah))
    foo.push_back(string(blah2))

    copy[vstr_itr,back_insert_itr]( foo.begin(),foo.end(), back_inserter[vector[string]](foo2) )
    
    xx = list(foo2)
    
    for i in xx:
        print i
