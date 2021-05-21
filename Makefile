# SPDX-License-Identifier: BSD-2-Clause-FreeBSD
#
# Copyright (c) 2021 Mateusz Piotrowski <0mp@FreeBSD.org>
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

BSD_INSTALL_SCRIPT?=	install -m 555
MKDIR?=			mkdir
SED?=			sed

DESTDIR?=
ETCDIR?=		${PREFIX}/etc/openconnect
RCDDIR?=		${PREFIX}/etc/rc.d
LOCALBASE?=		/usr/local
PREFIX?=		/usr/local

SERVICES=		openconnect openconnect_services

.SUFFIXES: .in

.PHONY: all
all: ${SERVICES}

openconnect: openconnect.in
openconnect_services: openconnect_services.in

.in:
	${SED} \
		-e 's|%%ETCDIR%%|${ETCDIR}|g' \
		-e 's|%%LOCALBASE%%|${LOCALBASE}|g' \
		-e 's|%%PREFIX%%|${PREFIX}|g' \
		-e 's|%%RCDDIR%%|${RCDDIR}|g' \
		${.ALLSRC} > ${.TARGET}

.PHONY: install
install:
	${BSD_INSTALL_SCRIPT} ${SERVICES} ${DESTDIR}${RCDDIR}
