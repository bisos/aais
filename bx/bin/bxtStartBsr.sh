#!/bin/bash

IimBriefDescription="bxtStartBsrA2Generic.sh: Create bases and starting points in SrBase."

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bxtStartBsr.sh,v 1.3 2016-07-29 02:02:53 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedBxtCommon.sh"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedBxtCommon.sh]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/aais/bx/bin/bxtStartBsr.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedBxtCommon.sh -l $0 "$@"
    exit $?
fi
####+END:

_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/ ::  [[elisp:(org-cycle)][| ]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[file:Panel.org][Panel]] | [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] | [[elisp:(bx:org:run-me)][Run]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]] | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] [[elisp:(org-cycle)][| ]]
** /Version Control/ ::  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_

_CommentBegin_
*      ================
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]] CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  Notes         :: *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  Xref          :: *[Related/Xrefs:]*  <<Xref->>  -- External Documents  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Xref         :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxRefModel/bxSrf/fullUsagePanel-en.org::Xref-][BISOS Panel]]  [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Desc          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]

_EOF_
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *Seed Extensions*
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Libs          :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/biso.libSh


# PRE parameters

baseDir=""

function G_postParamHook {
     lpCurrentsGet
     #bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
     return 0
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Examples      :: Examples [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_examples {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    visLibExamplesOutput ${G_myName} 

    #vis_startObjectGenExamples

    vis_startObjectFullExamples    
    
    lpReturn
}


function vis_startObjectFullExamples {
    EH_assert [[ $# -eq 0 ]]

    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    #typeset acctsList=$( bystarBacsAcctsList )

    oneBystarAcct=${currentBystarUid}

    #oneSr="iso/sr/geneweb/default/a2VirDoms/main"
    oneSr="so/sr/apache2/web3"

  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Start bxtSr Object In CWD" )
${G_myName} ${extraInfo} -i startObjectInCwd svcCapName svcCapFlavor svcName   # Assumes you are under bxo/so/sr/svcCap/svcName
${G_myName} ${extraInfo} -i startObjectInCwd apache2 generic docs              # Assumes you are under bxo/so/sr/svcCap/svcName
$( examplesSeperatorChapter "Transition Facilities -- Update bxtSr Object In CWD" )
${G_myName} ${extraInfo} -i updateObjectInCwd                                  # Auto Detect
${G_myName} ${extraInfo} -i updateObjectInCwd custom                           # for old dirs when objectType is not there
$( examplesSeperatorChapter "Start BxSR Service For BxO" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i startBsrSvc svcCapName svcCapFlavor svcName
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i startBsrSvc apache2 generic docs
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -f -i startBsrSvc apache2 generic docs
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -i startBsrSvc svcCapName svcCapFlavor svcName svcFqdn
_EOF_
}


noArgsHook() {
  vis_examples
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: vis_startObjectInCwd   [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_startObjectInCwd {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -ge 3 ]]

    typeset svcCapabilityName=$1
    typeset svcCapabilityFlavor=$2
    typeset svcName=$3

    typeset srFqdn=""
    
    if [[ $# -eq 4 ]] ; then
        srFqdn=$4
        #srDomName=${srFqdn%%.*}
    fi  

    typeset here=$( pwd )

    typeset bystarUid=$( vis_bisoIdGetThere ${here} )
    if [ -z "${bystarUid}" ] ; then
        EH_problem "Missing bxoId"
        EH_problem "You Are Likely Not Under A bxoBaseDir"
        lpReturn 101
    fi
    
    typeset srBase=$( vis_bisoSrGetThere ${here} )

    case ${svcCapabilityName} in
        "apache2")
            opDo bsrApache2Cap.sh -h -v -n showRun -p bystarUid=${bystarUid} -p sr=${srBase} -i srBaseStart ${svcCapabilityFlavor} ${svcName} ${srFqdn}     
            ;;
        *)
            EH_problem "Unexpected this=${svcCapabilityName}"
            lpReturn 1
            ;;
    esac

    lpReturn
}



_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: vis_startBsrSvc svcCapabilityName svcCapabilityFlavor svcName svcFqdn (-p bystarUid)  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_startBsrSvc {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -ge 3 ]]

    typeset svcCapabilityName=$1
    typeset svcCapabilityFlavor=$2
    typeset svcName=$3

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}

    typeset srBaseDir="${bystarUidHome}"/so/sr/${svcCapabilityName}/${svcName}

    if [ -d "${srBaseDir}" ] ; then
        if [ "${G_forceMode}" != "force" ] ; then
            EH_problem "${srBaseDir} Exists. Use updateObject if needed."
            lpReturn
        fi
    fi

    opDo FN_dirCreatePathIfNotThere ${srBaseDir}

    inBaseDirDo ${srBaseDir} ${G_myName} ${extraInfo} -i startObjectInCwd ${svcCapabilityName} ${svcCapabilityFlavor} ${svcName} 

    lpReturn
}




_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *End Of Editable Text*
_CommentEnd_

####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Common        ::  /[dblock] -- End-Of-File Controls/ [[elisp:(org-cycle)][| ]]
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
