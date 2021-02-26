function(target_clean_flags target)
    if(MSVC)
        target_compile_options(${target} PRIVATE /utf-8)

        target_compile_definitions(${target} PRIVATE NOGDI)
        target_compile_definitions(${target} PRIVATE NOMINMAX)
        target_compile_definitions(${target} PRIVATE VC_EXTRALEAN)
        target_compile_definitions(${target} PRIVATE WIN32_LEAN_AND_MEAN)

        if(NOT "${CMAKE_CXX_COMPILER_ID}" MATCHES "(Apple)?[Cc]lang")
            target_compile_options(${PROJECT_NAME} PRIVATE /experimental:external /external:W0 /permissive-)
        endif()
    endif()
endfunction()
