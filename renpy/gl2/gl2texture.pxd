# Copyright 2004-2014 Tom Rothamel <pytom@bishoujo.us>
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

from uguugl cimport *
from renpy.gl2.gl2shader cimport Program
from renpy.gl2.gl2geometry cimport Mesh
from renpy.gl2.gl2draw cimport GL2Draw

cdef class TextureLoader:

    # The draw object associated with this TextureLoader
    cdef GL2Draw draw

    # All the texture number currently allocated by this loader.
    cdef set allocated

    # A list of (number, generation) pairs for textures that need to be freed.
    cdef list free_list

    # The total size (in bytes) of all the textures that have been allocated
    # but not deallocated.
    cdef int total_texture_size

    # The color renderbuffer object used for fast texture loading.
    cdef GLuint ftl_color_renderbuffer

    # The depth renderbuffer object use for fast texture loading.
    cdef GLuint ftl_depth_renderbuffer

    # The framebuffer object used for fast texture loading.
    cdef GLuint ftl_fbo

    # The program used for fast texture loading
    cdef Program ftl_program

    # The queue of textures that need to be loaded.
    cdef object texture_load_queue

    # The maximum size of a texture.
    cdef GLint max_texture_width
    cdef GLint max_texture_height


cdef class GLTexture:

    # The size of the texture, in pixels.
    cdef public int width
    cdef public int height

    # The number of the texture in OpenGL.
    cdef public unsigned int number

    # Has this texture been loaded yet?
    cdef public bint loaded

    # If we are doing in-place loading, this is the data that's used for
    # that.
    cdef object surface

    # If we're not doing in-place loading, this is the data that's used for
    # that.
    cdef unsigned char *data

    # The texture loader associated with this texture.
    cdef TextureLoader loader
