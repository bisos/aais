#!/bin/bash

IimBriefDescription="seedBsrDnsAgent.sh: to be used by bsrDnsAgent.sh with ./srInfo"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: seedBsrDnsAgent.sh,v 1.2 2016-07-25 05:23:42 lsipusr Exp $"
# *CopyLeft*
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:dblock:lsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/opt/public/osmt/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /opt/public/osmt/bin/seedBsrDnsAgent.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /opt/public/osmt/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:

_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/:  [[elisp:(org-cycle)][Fold]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[elisp:(bx:org:run-me)][RunMe]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]]  | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] | 
** /Version Control/:  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_

_CommentBegin_
*      ================
l*      ################ CONTENTS-LIST ################
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxISo/fullUsagePanel-en.org::Xref-BxISo][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*
**    *[[elisp:(org-cycle)][Description And Purpose]]*  [[elisp:(beginning-of-buffer)][Top]]  [[elisp:(org-cycle)][| ]] 
_EOF_
}

_CommentBegin_
*      ################      *Seed Extensions*
_CommentEnd_

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

# /opt/public/osmt/bin/biso.libSh
. ${opBinBase}/biso.libSh


# PRE parameters

baseDir=""

function G_postParamHook {
     return 0
}




# PRE parameters

baseDir=""

function G_postParamHook {
     return 0
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    typeset runInfo="-p ri=lsipusr:passive"

    #oneBystarUid=${currentBystarUid}
    #oneBystarUid=prompt
    oneBystarUid=current

    typeset examplesInfo="${extraInfo} ${runInfo}"

    typeset srFqdn=$( fileParamManage.py -i fileParamReadPath ./srInfo/srFqdn )
    typeset srBaseDir=$( pwd )
    typeset isoId=$( ${G_myName} ${extraInfo} -i bisoIdGetThere $( pwd ) )
    typeset sr=$( ${G_myName} ${extraInfo} -i bisoSrGetThere $( pwd ) )
    typeset svcCapability=$( fileParamManage.py -i fileParamReadPath ./srInfo/svcCapability )

    visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Service Realization Agent" )
$( examplesSeperatorSection "Get SR Info" )
fileParamManage.py -i fileParamWritePath ./srInfo/svcCapability bsrGenewebManage.sh
${G_myName} ${extraInfo} -i srFqdnGet
$( examplesSeperatorSection "Get SR LogBase" )
${G_myName} ${extraInfo} -i srLogsBase
$( examplesSeperatorSection "Initial Bxt Object Creation/Update" )
bxtStartCommon.sh  -i startObjectUpdateInThere $( pwd )  # Auto Detect -- NOTYET
$( examplesSeperatorSection "Service Capability: ${svcCapability}" )
${svcCapability}
${svcCapability} -h -v -n showRun -p bystarUid=${isoId} -p sr=${sr} -i fullUpdate 
$( examplesSeperatorSection "Seed Candidates" )
${G_myName} ${extraInfo} -i bisoBaseGetThere $( pwd )
${G_myName} ${extraInfo} -i bisoSrGetThere $( pwd )
${G_myName} ${extraInfo} -i bisoIdFromBase $( echo ~ea-59070 )
${G_myName} ${extraInfo} -i bisoIdGetThere $( pwd )
$( examplesSeperatorSection "Initial Templates Development" )
diff ./bsrDnsAgent.sh  /libre/ByStar/InitialTemplates/iso/sr/common/bsrDnsAgent.sh
cp ./bsrDnsAgent.sh  /libre/ByStar/InitialTemplates/iso/sr/common/bsrDnsAgent.sh
cp /libre/ByStar/InitialTemplates/iso/sr/common/bsrDnsAgent.sh ./bsrDnsAgent.sh
_EOF_

  hookRun "examplesHookPost"
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Start Examples
_CommentEnd_


function vis_startObjectGenExamples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    typeset runInfo="-p ri=lsipusr:passive"

    #oneBystarUid=${currentBystarUid}
    #oneBystarUid=prompt
    oneBystarUid=prompt

    #oneBystarAcct=$( echo ${acctsList} | head -1 )
    #oneBystarAcct=${currentBystarUid}
    oneBystarAcct=prompt

    oneSr="iso/sr/apache2/git"

    typeset examplesInfo="${extraInfo} ${runInfo}"

    typeset srFqdn=$( fileParamManage.py -i fileParamReadPath ./srInfo/srFqdn )
    typeset srBaseDir=$( pwd )
    typeset isoId="ea-59075"   # Should Be Auto Gened
    typeset sr="NOTYET, This dir - base"
    typeset svcCapability="bystarGitoliteHttpAdmin.sh"

    oneSrPlone3Default="iso/sr/plone3/default"
    oneSrGeneweb2Default="iso/sr/geneweb2/default"
    oneSrDjango1_6Default="iso/sr/django1_6/default"
    oneSrQmail1_06Default="iso/sr/qmail1_06/default"

    oneSrApache2Git="iso/sr/apache2/git"
    oneSrApache2Web="iso/sr/apache2/web"

    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: Menu for Starting New Objects
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

cat  << _EOF_
$( examplesSeperatorChapter "Create/Update Web Service Realization Base" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -p sr=${oneSr} -i srBaseStart plone3
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -p sr=${oneSrGeneweb2} -i srBaseStart geneweb
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -p sr=${oneSrApache2Git} -i srBaseStart apache2 
$( examplesSeperatorChapter "Create/Update Mail Service Realization Base" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -p sr=${oneSr} -i srBaseStart qmail1_06
$( examplesSeperatorChapter "Create/Update Git Service Realization Base" )
${G_myName} ${extraInfo} -p bystarUid=${oneBystarAcct} -p sr=${oneSr} -i srBaseStart git
_EOF_
}



noArgsHook() {
  vis_examples
}



_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Interactively Invokable Functions (IIF)s | 
_CommentEnd_


function vis_srFqdnGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo fileParamManage.py -i fileParamReadPath ./srInfo/srFqdn
    EH_retOnFail

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== srBaseStart and srBaseUpdate -- Object Method Dispatchers
_CommentEnd_


function vis_srBaseStart {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Based srCap we dispatch to bsrCapManage.sh
_EOF_
    }

    EH_assert [[ $# -ge 1 ]]

    typeset srCap=$1

    if [ -z "${bystarUid}" ] ; then
        EH_problem ""
    fi

    if [ -z "${sr}" ] ; then
        EH_problem ""
    fi

    case "${srCap}" in
        "apache2")
            EH_problem "NOTYET"
            ;;
        "plone3")
            EH_problem "NOTYET"
            ;;
        "geneweb")
            opDo bsrGenewebManage.sh -h -v -n showRun -p bystarUid=${bystarUid} -p sr=${sr} -i srBaseStart
            ;;
        *)
            EH_problem ""
    esac

    lpReturn
}


function vis_startObjectUpdateInCwd {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}:Description: 
Generate file-var-parameters in current working directory.
\$1 (optional) is objectType. If no \$1 then objectType is determined from content of cwd.
Primarily a transitional facility.
_EOF_
    }

    EH_assert [[ $# -le 1 ]]

    typeset here=.

    bystarAcctPathAnalyze ${here}

    if [ $# -eq 1 ] ; then
        thisObjectType=$1

        if [ -f ${poObjectTypeFileName} ] ; then
            currentObjectType=$( cat ${poObjectTypeFileName} )
            if [ "${thisObjectType}" != "${currentObjectType}" ] ; then
                EH_problem "objectType Mis-Match -- ${thisObjectType} != ${currentObjectType}"
                EH_retOnFail
            fi
        else
            opDo eval echo "${thisObjectType}" \> "${poObjectTypeFileName}"
        fi
    else
        if [ -f ${poObjectTypeFileName} ] ; then
            thisObjectType=$( cat ${poObjectTypeFileName} )
        else
            thisObjectType=$( vis_objectTypeInCwdGuess )
            opDo eval echo "${thisObjectType}" \> "${poObjectTypeFileName}"
        fi
    fi

    startUpdateFunc=$( eval echo '$'{object_${thisObjectType}[startUpdate]} )

    opDo ${startUpdateFunc} 

    #opDo vis_plone3ProcUpgrade

    lpReturn
}

_CommentBegin_
*      ################      *End Of Editable Text*
_CommentEnd_

####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]======  /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
