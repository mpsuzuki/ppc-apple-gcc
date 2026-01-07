# This file is part of Autoconf.                       -*- Autoconf -*-
# Checking for headers.

#
# This file is based on Autoconf-2.59 headers.m4, which was designed
# for K&R + C89 systems.  Some tests have mismatches with later C
# standards or implementations, this m4 file has tweaks for them.
#
# 1) Include <stdlib.h> if it is available.
#    C11 prohibits the reference of functions without declarations,
#    So newer versions of Clang (> 15?) refuses to compile the code
#    calling "exit()" without including <stlib.h>.
#
#

#
# Copyright (C) 2000, 2001, 2002, 2003 Free Software Foundation, Inc.
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2, or (at your option)
# any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA
# 02111-1307, USA.
#
# As a special exception, the Free Software Foundation gives unlimited
# permission to copy, distribute and modify the configure scripts that
# are the output of Autoconf.  You need not follow the terms of the GNU
# General Public License when using or distributing such scripts, even
# though portions of the text of Autoconf appear in them.  The GNU
# General Public License (GPL) does govern all other use of the material
# that constitutes the Autoconf program.
#
# Certain portions of the Autoconf source text are designed to be copied
# (in certain cases, depending on the input) into the output of
# Autoconf.  We call these the "data" portions.  The rest of the Autoconf
# source text consists of comments plus executable code that decides which
# of the data portions to output in any given case.  We call these
# comments and executable code the "non-data" portions.  Autoconf never
# copies any of the non-data portions into its output.
#
# This special exception to the GPL applies to versions of Autoconf
# released by the Free Software Foundation.  When you make and
# distribute a modified version of Autoconf, you may extend this special
# exception to the GPL to apply to your modified version as well, *unless*
# your modified version has the potential to copy into its output some
# of the text that was the non-data portion of the version that you started
# with.  (In other words, unless your change moves or copies text from
# the non-data portions to the data portions.)  If your modification has
# such potential, you must delete any notice of this special exception
# to the GPL from your modified version.
#
# Written by David MacKenzie, with help from
# Franc,ois Pinard, Karl Berry, Richard Pixley, Ian Lance Taylor,
# Roland McGrath, Noah Friedman, david d zuhn, and many others.


AC_DEFUN([AC_HEADER_STDC],
[AC_CACHE_CHECK(for ANSI C header files, ac_cv_header_stdc,
[AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[#include <stdlib.h>
#include <stdarg.h>
#include <string.h>
#include <float.h>
]])],
		    [ac_cv_header_stdc=yes],
		    [ac_cv_header_stdc=no])

if test $ac_cv_header_stdc = yes; then
  # SunOS 4.x string.h does not declare mem*, contrary to ANSI.
  AC_EGREP_HEADER(memchr, string.h, , ac_cv_header_stdc=no)
fi

if test $ac_cv_header_stdc = yes; then
  # ISC 2.0.2 stdlib.h does not declare free, contrary to ANSI.
  AC_EGREP_HEADER(free, stdlib.h, , ac_cv_header_stdc=no)
fi

if test $ac_cv_header_stdc = yes; then
  # /bin/cc in Irix-4.0.5 gets non-ANSI ctype macros unless using -ansi.
  AC_RUN_IFELSE([AC_LANG_SOURCE(
[[
/*
 * C11 prohibits undeclared reference of functions,
 * <stdlib.h> should be included if it is available.
 */
#ifdef HAVE_STDLIB_H
#include <stdlib.h>
#endif

#include <ctype.h>
#if ((' ' & 0x0FF) == 0x020)
# define ISLOWER(c) ('a' <= (c) && (c) <= 'z')
# define TOUPPER(c) (ISLOWER(c) ? 'A' + ((c) - 'a') : (c))
#else
# define ISLOWER(c) \
		   (('a' <= (c) && (c) <= 'i') \
		     || ('j' <= (c) && (c) <= 'r') \
		     || ('s' <= (c) && (c) <= 'z'))
# define TOUPPER(c) (ISLOWER(c) ? ((c) | 0x40) : (c))
#endif

#define XOR(e, f) (((e) && !(f)) || (!(e) && (f)))
int
main ()
{
  int i;
  for (i = 0; i < 256; i++)
    if (XOR (islower (i), ISLOWER (i))
	|| toupper (i) != TOUPPER (i))
      exit(2);
  exit (0);
}]])], , ac_cv_header_stdc=no, :)
fi])
if test $ac_cv_header_stdc = yes; then
  AC_DEFINE(STDC_HEADERS, 1,
	    [Define to 1 if you have the ANSI C header files.])
fi
])# AC_HEADER_STDC
