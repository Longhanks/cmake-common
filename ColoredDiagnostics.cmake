# From https://github.com/llvm/llvm-project/blob/e9f9ec837d447857076bf337e811dd2077a72f18/llvm/cmake/modules/HandleLLVMOptions.cmake#L866
# clang and gcc don't default-print colored diagnostics when invoked from Ninja.
function(project_enable_colored_diagnostics)
  if(UNIX AND
     CMAKE_GENERATOR STREQUAL "Ninja" AND
     (CMAKE_CXX_COMPILER_ID MATCHES "Clang" OR
      (CMAKE_CXX_COMPILER_ID STREQUAL "GNU" AND
       NOT (CMAKE_CXX_COMPILER_VERSION VERSION_LESS 4.9))))
    set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -fdiagnostics-color" PARENT_SCOPE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fdiagnostics-color" PARENT_SCOPE)
  endif()
endfunction()
