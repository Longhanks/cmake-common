function(target_add_compiler_warnings target)
  if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "GNU")
    # gcc 5
    list(APPEND COMPILER_WARNINGS
      -Wall
      -Warray-bounds=2
      -Wcast-qual
      -Wconversion
      -Wctor-dtor-privacy
      -Wdeprecated-declarations
      -Wdisabled-optimization
      -Wdouble-promotion
      -Wextra
      -Wformat=2
      -Wlogical-op
      -Wmissing-include-dirs
      -Wnoexcept
      -Wnon-virtual-dtor
      -Wold-style-cast
      -Woverloaded-virtual
      -Wpedantic
      -Wpointer-arith
      -Wredundant-decls
      -Wshadow
      -Wsign-conversion
      -Wsized-deallocation
      -Wtrampolines
      -Wundef
      -Wunused
      -Wunused-parameter
      -Wuseless-cast
      -Wvector-operation-performance
      -Wwrite-strings
      -pedantic-errors
    )

    # gcc 6
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 6.1)
      list(APPEND COMPILER_WARNINGS
        -Wduplicated-cond
        -Wmisleading-indentation
        -Wnull-dereference
        -Wshift-overflow=2
      )
    endif()

    # gcc 7
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 7.1)
      list(APPEND COMPILER_WARNINGS
        -Wduplicated-branches
      )
    endif()

    # gcc 9
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 9.1)
      list(APPEND COMPILER_WARNINGS
        -Wzero-as-null-pointer-constant
      )
    endif()

    # gcc 10
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 10.1)
      list(APPEND COMPILER_WARNINGS
        -Wredundant-tags
      )
    endif()

    # gcc >=10.2
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 10.2)
      list(APPEND COMPILER_WARNINGS
        -Wmismatched-tags
      )
    endif()

    # gcc 11
    if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 11.1)
      list(APPEND COMPILER_WARNINGS
        -Wenum-conversion
      )
    endif()

  elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang")
    list(APPEND COMPILER_WARNINGS
      -Weverything
      -Wno-c++98-compat
      -Wno-c++98-compat-pedantic
      -Wno-padded
    )

    # AppleClang 12 == clang 10
    if("${CMAKE_CXX_COMPILER_ID}" STREQUAL "AppleClang")
      if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 12.0)
        list(APPEND COMPILER_WARNINGS
          -Wno-poison-system-directories
          )
      endif()
    # Regular clang
    else()
      if(CMAKE_CXX_COMPILER_VERSION VERSION_LESS 13.0)
        list(APPEND COMPILER_WARNINGS
          -Wno-return-std-move-in-c++11
        )
      endif()
      if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 9.0)
        list(APPEND COMPILER_WARNINGS
          -Wno-ctad-maybe-unsupported
        )
      endif()
      if(CMAKE_CXX_COMPILER_VERSION VERSION_GREATER_EQUAL 10.0)
        list(APPEND COMPILER_WARNINGS
          -Wno-poison-system-directories
        )
      endif()
    endif()

  else()
    list(APPEND COMPILER_WARNINGS
      /W4
      /w14242
      /w14254
      /w14263
      /w14265
      /w14287
      /we4289
      /w14296
      /w14311
      /w14545
      /w14546
      /w14547
      /w14549
      /w14555
      /w14619
      /w14640
      /w14826
      /w14905
      /w14906
      /w14928
    )
  endif()

  list(APPEND CXX_ONLY_COMPILER_WARNINGS
    -Wctor-dtor-privacy
    -Wmismatched-tags
    -Wnoexcept
    -Wnon-virtual-dtor
    -Wold-style-cast
    -Woverloaded-virtual
    -Wredundant-tags
    -Wsized-deallocation
    -Wuseless-cast
    -Wzero-as-null-pointer-constant
  )

  foreach(COMPILER_WARNING ${COMPILER_WARNINGS})
    if(NOT ${COMPILER_WARNING} IN_LIST CXX_ONLY_COMPILER_WARNINGS)
      list(APPEND C_COMPILER_WARNINGS ${COMPILER_WARNING})
    endif()
  endforeach()

  string(REPLACE ";" " " C_COMPILER_WARNINGS_STR "${C_COMPILER_WARNINGS}")
  string(REPLACE ";" " " CXX_COMPILER_WARNINGS_STR "${COMPILER_WARNINGS}")

  get_target_property(${target}_SOURCES ${target} SOURCES)

  foreach(${target}_SOURCE ${${target}_SOURCES})
    get_source_file_property(${${target}_SOURCE}_LANG ${${target}_SOURCE} LANGUAGE)
    if("${${${target}_SOURCE}_LANG}" STREQUAL "C")
      set_source_files_properties(${${target}_SOURCE} PROPERTIES COMPILE_FLAGS "${C_COMPILER_WARNINGS_STR}")
    elseif("${${${target}_SOURCE}_LANG}" STREQUAL "CXX")
      set_source_files_properties(${${target}_SOURCE} PROPERTIES COMPILE_FLAGS "${CXX_COMPILER_WARNINGS_STR}")
    endif()
  endforeach()
endfunction()
