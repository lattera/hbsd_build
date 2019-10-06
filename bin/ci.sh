#!/bin/sh
#-
# Copyright (c) 2019 HardenedBSD
# Author: Shawn Webb <shawn.webb@hardenedbsd.org>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR AND CONTRIBUTORS ``AS IS'' AND
# ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED.  IN NO EVENT SHALL THE AUTHOR OR CONTRIBUTORS BE LIABLE
# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS
# OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
# OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
# SUCH DAMAGE.

. ./lib/build.sh
. ./lib/publish.sh
. ./lib/util.sh

main() {
	HBSD_INDEX_FILE=/build/index
	HBSD_KERNEL=HARDENEDBSD
	HBSD_LOCKFILE=/tmp/13-current.amd64.lock
	HBSD_NJOBS=4
	HBSD_OBJRELDIR=/usr/obj/scratch/src/hbsd-13/amd64.amd64/release
	HBSD_PUBDIR=/build/pub
	HBSD_SRC=/scratch/src/hbsd-13
	HBSD_STAGEDIR=/build/stage
	HBSD_TARGET=amd64
	HBSD_TARGET_ARCH=amd64
	HBSD_NOCLEAN="-DNO_CLEAN"

	assert_unlocked && \
	    lock_build && \
	    update_codebase && \
	    build_hardenedbsd && \
	    build_release && \
	    stage_release && \
	    sign_release && \
	    publish_release && \
	    kick_publisher_tires && \
	    unlock_build
	return ${?}
}

main ${0} $*
exit ${?}
