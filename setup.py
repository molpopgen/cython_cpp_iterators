from distutils.core import setup, Extension
from Cython.Build import cythonize
import platform, glob, sys

extensions=[Extension("iterator_test.iterator",sources=["iterator_test/iterator.pyx"]),
]

setup(name="iterator_test.iterator",
      ext_modules=cythonize(extensions))
