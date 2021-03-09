function(target_disable_rtti target)
  if(MSVC)
    target_compile_options(${target} PRIVATE /GR-)
  else()
    target_compile_options(${target} PRIVATE -fno-rtti)
  endif()
endfunction()
