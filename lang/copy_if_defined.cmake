

# cmut__lang__copy_if_defined(source destination)
# if variable "source" is defined, copy value of "source" in "destination"

macro( cmut__lang__copy_if_defined source destination )

    if ( DEFINED ${source} )
        set( ${destination} "${${source}}" )
    endif()

endmacro()
