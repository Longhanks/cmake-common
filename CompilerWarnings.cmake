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
        # -Wmismatched-tags needs either libstdc++ or gcc fix
        # libstdc++ fix https://gcc.gnu.org/bugzilla/show_bug.cgi?id=96063
        # gcc fix https://gcc.gnu.org/git/gitweb.cgi?p=gcc.git;h=5e4c9ebbab7bec3b5994f85aebce13bf37cf46e9
        # -Wmismatched-tags
        -Wredundant-tags
      )
    endif()

  elseif("${CMAKE_CXX_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang")
    list(APPEND COMPILER_WARNINGS
      -Weverything
      -Wno-c++98-compat
      -Wno-c++98-compat-pedantic
      -Wno-padded
      -Wno-return-std-move-in-c++11
    )

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

  string(REPLACE ";" " " COMPILER_WARNINGS_STR "${COMPILER_WARNINGS}")

  get_target_property(${target}_SOURCES ${PROJECT_NAME} SOURCES)

  foreach(${target}_SOURCE ${${target}_SOURCES})
    set_source_files_properties(${${target}_SOURCE} PROPERTIES COMPILE_FLAGS "${COMPILER_WARNINGS_STR}")
  endforeach()
endfunction()
