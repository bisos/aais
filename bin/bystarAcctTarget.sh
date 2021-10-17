#!/bin/bash

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
# {{{ DBLOCK-top-of-file
typeset RcsId="$Id: bystarAcctTarget.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
#  This is part of ByStar Libre Services. http://www.by-star.net
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal. 
# }}} DBLOCK-top-of-file
####+END:

####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedActions.bash"
# {{{ DBLOCK-seed-spec
if [ "${loadFiles}X" == "X" ] ; then
    /opt/public/osmt/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
# }}} DBLOCK-seed-spec
####+END:

# {{{ Help/Info

function vis_help {
    cat  << _EOF_
Initially on Service Creation (in bystarAcctAdmin.sh) mode=here.
For any Buid with a hereService, mode=live can be set.
For any Buid without a hereService mode is always live.

Only on a LIVE Bacs mode=live results in container parameters being set
with  vis_parLiveHereAccordingly.

Settings from this facility are mostly used in:
    ./bystarHereAcct.libSh
_EOF_
}

# }}}

# {{{ Prefaces

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lcnFileParams.libSh
. ${opBinBase}/lpParams.libSh

# ./lpXparams.libSh
. ${opBinBase}/lpXparams.libSh

# ./bystarLib.sh
. ${opBinBase}/bystarLib.sh
# ./bystarHereAcct.libSh
. ${opBinBase}/bystarHereAcct.libSh
# ./bystarCentralAcct.libSh
. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/mmaWebLib.sh

# PRE parameters optional

typeset -t assignedUserIdNumber=""


# ./bystarHook.libSh
. ${opBinBase}/bystarHook.libSh
. ${opBinBase}/bystarInfoBase.libSh

# ./bystarLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/bystarHereAcct.libSh

. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
# ./bystarDnsDomain.libSh 
. ${opBinBase}/bystarDnsDomain.libSh
. ${opBinBase}/mmaDnsLib.sh

. ${opBinBase}/lpCurrents.libSh

# ./lcaPlone3.libSh
. ${opBinBase}/lcaPlone3.libSh


# PRE parameters
typeset -t bystarUid="INVALID"

function G_postParamHook {
     lpCurrentsGet
     bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
     return 0
}

# }}}

# {{{ Examples

function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""

  #typeset acctsList=$( bystarBacsAcctsList )

  #oneBystarAcct=$( echo ${acctsList} | head -1 )
  #oneBystarAcct=${currentBystarUid}
  oneBystarAcct=ma-57000

 cat  << _EOF_
EXAMPLES:
${visLibExamples}
---- BYSTAR HOME BASE - INFORMATION ---
${G_myName} ${extraInfo} -p bystarUid=current -i targetModeReport
${G_myName} ${extraInfo} -p bystarUid=all -i targetModeReport
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i targetModeShow
egrep "^" ~${oneBystarAcct}/par.live/container/*
---- BYSTAR HOME BASE - SET MODE ---
${G_myName} ${extraInfo} -p bystarUid=current -p mode=here -i targetModeSet  # Points to Here
${G_myName} ${extraInfo} -p bystarUid=current -p mode=live -i targetModeSet  # Points to Live
---- BYSTAR HOME BASE ---
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i parLiveAssembleAndVcImport
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i parLiveHere              # Un-Conditionally Creates/Updates parLive
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i parLiveHereAccordingly   # Perhaps Creates/Updates parLive
---- xparams Invokations ----
lpEach.sh -i prepend "bystarUid=" ma-57007 | lpXparamsApply.sh -i xparamsProg ${G_myName} -p bystarUid='\${bystarUid}'  -i initialFullUpdate
lpEach.sh -i prepend "bystarUid=" ea-59043 sa-20000 | ${G_myName} -i xparamsFuncs vis_startHere vis_startHere
---- Mass Apply To All Here Accounts ----
bystarAcctInfo.sh -i hereBystarUidList 2> /dev/null | lpXparamsApply.sh -i xparamsProg ${G_myName} -p bystarUid='\${bystarUid}'  -i initialFullUpdate
---- Mass Apply To All InfoBase Accounts ----
bystarInfoBaseAdmin.sh  -i infoBaseBystarUidList 2> /dev/null | lpXparamsApply.sh -i xparamsProg ${G_myName} -p bystarUid='\${bystarUid}'  -i startHere
---- Misc For Now ----
_EOF_
}


noArgsHook() {
  vis_examples
}

# }}}


function vis_targetModeSet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Switch to live by 
      - Indicating that par.live container WILL be in use.
      - Disable DNS Resolution Faking
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 
    EH_assert bystarAcctTargetModePrep ${mode}

    opDoRet bystarAcctAnalyze ${bystarUid}
    EH_retOnFail

    typeset targetModeFile=${bystarUidHome}/par.live/targetMode.novc

    if [ -f  ${targetModeFile} ] ; then 
	opDoRet FN_fileSafeKeep ${targetModeFile}
    fi
    
    opDo eval "echo \"${mode}\" > ${targetModeFile}"

    #
    # Set dns resolver mode
    #
    case ${mode} in
	"here")
	    opDo bystarDnsResolvAdmin.sh -h -v -n showRun -p bystarUid=${bystarUid} -p DomainForm=all -i dnscacheFakeHere
	    ;;
	"live")
	    opDo bystarDnsResolvAdmin.sh -h -v -n showRun -p bystarUid=${bystarUid} -p DomainForm=all -i dnscacheFakeHereNot
	    ;;
	*)
	    EH_problem "mode=${thisMode} -- Unknown -- invalid mode"
	    lpReturn 101
	    ;;
    esac

    lpReturn 
}

function vis_targetModeShow {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Puts on stdout current target mode, Lower level than vis_targetModeReport.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 

    opDoRet bystarAcctAnalyze ${bystarUid}
    EH_retOnFail

    typeset targetModeFile=${bystarUidHome}/par.live/targetMode.novc

    #  ~sa-20000/
    if [ -f  ${targetModeFile} ] ; then 
	opDoRet cat ${targetModeFile}
    else
	ANT_raw "Missing targetModeFile ${targetModeFile}"
    fi
    
    lpReturn 
}

function vis_targetModeReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Uses vis_targetModeShow to produce human reports of target mode.
_EOF_
    }
    typeset thisFunc=${G_thisFunc}
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 

    if [[ "${bystarUid}" == "all" ]] ; then
	typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
	for bystarUid in ${hereBystarUidList} ; do
	    ${thisFunc}
	done
	lpReturn
    fi

    typeset thisTargetMode=$( vis_targetModeShow 2> /dev/null )

    ANT_raw "bystarUid=${bystarUid} targetMode=${thisTargetMode}"
    
    lpReturn 
}



function vis_initialFullUpdate {
    opDoComplain vis_parLiveAssemble
}


function vis_parLiveAssembleAndVcImport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
vis_parLiveHereAccordingly and VC imports par.live
_EOF_
    }
    typeset thisFunc=${G_thisFunc}
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 

    if [[ "${bystarUid}" == "all" ]] ; then
	typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
	for bystarUid in ${hereBystarUidList} ; do
	    ${thisFunc}
	done
	lpReturn
    fi

    typeset retVal=0

    opDoRet bystarAcctAnalyze ${bystarUid}
    EH_retOnFail

    opDoComplain vis_parLiveHereAccordingly
    EH_retOnFail

    opDoComplain lcaCvsAdmin.sh -h -v -n showRun -i atBaseNewAddDir ${bystarUidHome} par.live

    lpReturn ${retVal}
}

function vis_parLiveHere {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Unconditionally creates ${bystarUidHome}/par.live/container based on Here and configures it as live.
Is used by vis_parLiveHereAccordingly.
_EOF_
    }
    typeset thisFunc=${G_thisFunc}
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 

    if [[ "${bystarUid}" == "all" ]] ; then
	typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
	for bystarUid in ${hereBystarUidList} ; do
	    ${thisFunc}
	done
	lpReturn
    fi

    typeset retVal=0

    opDoRet bystarAcctAnalyze ${bystarUid}
    EH_retOnFail

     if [ ! -d ${bystarUidHome}/par.live/container ] ; then 
	opDoRet mkdir -p ${bystarUidHome}/par.live/container
    fi

    opDo eval "echo ${opRunHostName} > ${bystarUidHome}/par.live/container/bacsName"

    typeset thisIpAddr=$( mmaLayer3Admin.sh -i runFunc givenInterfaceGetIPAddr eth0 )
    opDo eval "echo ${thisIpAddr} > ${bystarUidHome}/par.live/container/ipAddr"

    opDo eval "vis_hereContainerPlone3UserGet > ${bystarUidHome}/par.live/container/plone3User"
    opDo eval "vis_hereContainerPlone3PasswdGet > ${bystarUidHome}/par.live/container/plone3Passwd"

    lpReturn ${retVal}
}

function vis_parLiveHereAccordingly {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Uses vis_parLiveHere. 
vis_parLiveHere is invoked: if par.live/container does not exist or if this platform is configured as live.
_EOF_
    }
    typeset thisFunc=${G_thisFunc}
    EH_assert [[ $# -eq 0 ]]
    EH_assert bystarUidHerePrep 

    if [[ "${bystarUid}" == "all" ]] ; then
	typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
	for bystarUid in ${hereBystarUidList} ; do
	    ${thisFunc}
	done
	lpReturn
    fi

    typeset retVal=0

    opDoRet bystarAcctAnalyze ${bystarUid}
    EH_retOnFail

    if [ ! -d ${bystarUidHome}/par.live/container ] ; then 
	opDoRet vis_parLiveHere
    else
	ANT_raw "NOTYET, ${bystarUidHome}/par.live/container is in place"
	ANT_raw "NOTYET, if cp_platformUsageMode=live; then run vis_parLiveHere"
    fi

    lpReturn ${retVal}
}



####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
# {{{ DBLOCK-end-of-file
#local variables:
#major-mode: sh-mode
#folded-file: nil
#fill-column: 90
# end:
# }}} DBLOCK-end-of-file
####+END:
