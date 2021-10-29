#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" :partof "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bystarBarcProc.sh,v 1.1.1.1 2016-06-08 23:49:52 lsipusr Exp $"
# *CopyLeft*
#  This is part of ByStar Libre Services. http://www.by-star.net
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/bsip/bin/bystarBarcProc.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:


. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bystarLib.sh

# /opt/public/osmt/bin/bystarBarc.libSh 
. ${palsBinBase}/bystarBarc.libSh
. ${opBinBase}/opDoAtAsLib.sh

. ${opBinBase}/bystarHook.libSh

# /opt/public/osmt/bin/bystarInfoBase.libSh 
. ${palsBinBase}/bystarInfoBase.libSh
. ${palsBinBase}/bystarNspLib.sh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh


# /bisos/core/bsip/bin/bisosCurrents_lib.sh
. ${opBinBase}/bisosCurrents_lib.sh

# PRE parameters
typeset -t BarcFile="MANDATORY"

function G_postParamHook {
    if [ "${BarcFile}_" != "MANDATORY_" ] ; then
        BarcFile=$( FN_absolutePathGet ${BarcFile} )
    fi
    lpCurrentsGet
    lpReturn 0
}

noArgsHook() {
  vis_examples
}

function vis_examples {
    extraInfo="-h -v -n showRun"
    oneBarcFile="/libre/ByStar/InfoBase/BARC/BYNAME/TRIAL/090125235441_25039.BARC"
 cat  << _EOF_
EXAMPLES:
--- BARC Processors ---
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i BarcVerify
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i BarcRegister
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i acctCreate
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i startToEssentials
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i fullCreateFg
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i fullCreateBg
--- BARC RENEW/MOVE  ---
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i renewPassive
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i fullCreateFg
--- BARC Developer Mode ---
${G_myName} ${extraInfo} -p BarcFile="${oneBarcFile}" -i fullCreateDev
_EOF_
}

function vis_BarcVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${BarcFile}_" != "MANDATORY_" ]]
    
    . ${BarcFile}
    BarcContainer

    echo ${bc_serviceType}
    echo ${bc_serviceSupportType}
}

function vis_BarcRegister {
#set -x
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${BarcFile}_" != "MANDATORY_" ]]

    opDo bystarRbaeAdmin.sh -p BarcFile="${BarcFile}" -i RbaeCreate
}

function vis_acctCreate {
    RBAE=$( vis_BarcRegister 2> /dev/null )

    if [ "${RBAE}_" == "_" ] ; then
       EH_problem "empty RBAE"
       return 101
    fi

    opDo bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i acctCreate
}

function vis_fullCreateFg {
    if ! vis_acctCreate ; then 
        return 101
    fi
    opDoAfterPause bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i fullUpdate
}

function vis_startToEssentials {
    if ! vis_acctCreate ; then 
        return 101
    fi

    #bpoId=$( bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i startToEssentials 2> /dev/null )
    #bpoId=$( bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i startToEssentials )

    #echo ${bystarUid}
    
    opDo bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i startToEssentials


}

function vis_fullCreateBg {
    if ! vis_acctCreate ; then 
        return 101
    fi

    opDoAfterPause bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i fullUpdate &
}

function vis_fullCreateDev {
    if ! vis_acctCreate ; then 
        return 101
    fi

    opDoAfterPause bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i fullUpdate
}


function vis_renewPassive {
    RBAE=$( vis_BarcRegister 2> /dev/null )
    # bystarUid should be set ...

    if [ "${RBAE}_" == "_" ] ; then
       EH_problem "empty RBAE"
       return 101
    fi

    opDo bystarAcctAdmin.sh ${G_commandOptions} -p RBAE="$RBAE" -i acctCreate
}
