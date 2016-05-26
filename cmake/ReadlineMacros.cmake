# This file is included by FindReadline.cmake, don't include it directly.

#=============================================================================
# Copyright (C) 2012 HellGround <http://www.hellground.pl/>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#=============================================================================


macro(FIND_TERMCAP_IMPL)
    set(TERMCAP_IMPL "standalone" "termcap" "curses" "ncurses")
    foreach(impl ${TERMCAP_IMPL})
        find_termcap_impl_in_readline(${impl})
        if (READLINE_TERMCAP_FOUND)
            break()
        endif()
    endforeach()
endmacro()

macro(FIND_TERMCAP_IMPL_IN_READLINE name)

    set(CMAKE_REQUIRED_LIBRARIES ${READLINE_LIBRARY})

    if (NOT "${name}" STREQUAL "standalone")
        find_library(READLINE_${name}_LIBRARY NAMES ${name})
        mark_as_advanced(READLINE_${name}_LIBRARY)

        if (READLINE_${name}_LIBRARY)
            set(CMAKE_REQUIRED_LIBRARIES ${CMAKE_REQUIRED_LIBRARIES}
                                         ${READLINE_${name}_LIBRARY})

            string(TOUPPER TERMCAP_IMPL_IN_${name} TERMCAP_CONF_NAME)
        endif()
    else()
        set(READLINE_${name}_LIBRARY "")
        string(TOUPPER ${name} TERMCAP_CONF_NAME)
    endif()

    if (NOT READLINE_${name}_LIBRARY STREQUAL READLINE_${name}-NOTFOUND)
        include(CheckCXXSourceCompiles)

        check_cxx_source_compiles("
             #include <stdio.h>
             #include <readline/readline.h>
             #include <readline/history.h>
             int main(int argc, char **argv)
             {
                 char *line = readline (\"Enter a line: \");
                 add_history(line);
                 return 0;
             }" HAVE_READLINE_${TERMCAP_CONF_NAME})

        if (HAVE_READLINE_${TERMCAP_CONF_NAME})
             set(READLINE_TERMCAP_LIBRARIES ${READLINE_${name}_LIBRARY})
             set(READLINE_TERMCAP_FOUND "TRUE")
        endif()

    endif()

endmacro()
