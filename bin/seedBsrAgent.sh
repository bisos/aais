#!/bin/bash

IimBriefDescription="seedBsrAgent.sh: to be used by bsrAgent.sh -- in bxo/sr/cap/instance"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: seedBsrAgent.sh,v 1.5 2016-07-29 02:02:53 lsipusr Exp $"
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
*  /This File/ :: /opt/public/osmt/bin/seedBsrAgent.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /opt/public/osmt/bin/seedActions.bash -l $0 "$@" 
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
*      ################ CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  Notes         :: *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  Xref          :: *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Xref         :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxRefModel/bxSrf/fullUsagePanel-en.org::Xref-][BxSRF and BISP Panel]]  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Xref         :: /libre/ByStar/InitialTemplates/activeDocs/bxServices/bxsrModes/fullUsagePanel-en.org  [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Desc          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]
**    *[[elisp:(org-cycle)][Description And Purpose]]*  [[elisp:(beginning-of-buffer)][Top]]  [[elisp:(org-cycle)][| ]] 
_EOF_
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Libs          :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
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
*  [[elisp:(org-cycle)][| ]]  Example       :: Examples [[elisp:(org-cycle)][| ]]
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
fileParamManage.py -i fileParamWritePath ./srInfo/srFqdn genealogy.bymemory.net
fileParamManage.py -i fileParamWritePath ./srInfo/srDomName genealogy
${G_myName} ${extraInfo} -i svcCapability
${G_myName} ${extraInfo} -i srFqdnGet
${G_myName} ${extraInfo} -i srDomName
$( examplesSeperatorSection "Get SR LogBase" )
${G_myName} ${extraInfo} -i srLogsBase
$( examplesSeperatorSection "Produce a Full Report Of BSR's Context" )
${G_myName} ${extraInfo} -i fullReport
$( examplesSeperatorSection "Initial Bxt Object Creation/Update" )
bxtStartCommon.sh  -i startObjectUpdateInThere $( pwd )  # Auto Detect -- NOTYET
$( examplesSeperatorSection "Service Capability: ${svcCapability}" )
${svcCapability}
${svcCapability} -h -v -n showRun -p bpoId=${isoId} -p sr=${sr} -i fullUpdate 
$( examplesSeperatorSection "Based On path, BxO -i GetThere" )
${G_myName} ${extraInfo} -i bisoBaseGetThere $( pwd )
${G_myName} ${extraInfo} -i bisoSrGetThere $( pwd )
${G_myName} ${extraInfo} -i bisoIdFromBase $( echo ~sa-20000 )
${G_myName} ${extraInfo} -i bisoIdGetThere $( pwd )
$( examplesSeperatorSection "Based On cwd, BxO -i GetHere" )
${G_myName} ${extraInfo} -i bisoBaseGetHere
${G_myName} ${extraInfo} -i bisoSrGetHere
${G_myName} ${extraInfo} -i bisoIdGetHere
$( examplesSeperatorSection "Invoke svcCapability -i fullUpdate" )
${G_myName} ${extraInfo} -i svcCapabilityFullUpdate
$( examplesSeperatorSection "Initial Templates Development" )
diff ./bsrAgent.sh  /libre/ByStar/InitialTemplates/iso/sr/common/bsrAgent.sh
cp ./bsrAgent.sh  /libre/ByStar/InitialTemplates/iso/sr/common/bsrAgent.sh
cp /libre/ByStar/InitialTemplates/iso/sr/common/bsrAgent.sh ./bsrAgent.sh
$( examplesSeperatorSection "Panel.org -- Initial Templates Development" )
diff ./Panel.org  /libre/ByStar/InitialTemplates/iso/sr/common/Panel.org
cp ./Panel.org  /libre/ByStar/InitialTemplates/iso/sr/common/Panel.org
cp /libre/ByStar/InitialTemplates/iso/sr/common/Panel.org ./Panel.org
_EOF_

  hookRun "examplesHookPost"
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Example       :: Start Examples [[elisp:(org-cycle)][| ]]
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
    #typeset svcCapability="bystarGitoliteHttpAdmin.sh"

    oneSrPlone3Default="iso/sr/plone3/default"
    # ~sa-20000/iso/sr/geneweb/default/
    oneSrGeneweb2Default="iso/sr/geneweb/default"
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
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srBaseStart plone3
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSrGeneweb2Default} -i srBaseStart geneweb
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSrApache2Git} -i srBaseStart apache2 
$( examplesSeperatorChapter "Create/Update Mail Service Realization Base" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srBaseStart qmail1_06
$( examplesSeperatorChapter "Create/Update Git Service Realization Base" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srBaseStart git
_EOF_
}



noArgsHook() {
  vis_examples
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: SR File Params SVC Get/Set -- vis_svcCapabilityGet vis_svcNameGet   [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_svcCapabilityAgentGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo fileParamManage.py -i fileParamReadPath ./srInfo/svcCapabilityAgent
    EH_retOnFail

    lpReturn
}

function vis_svcCapabilityFlavorGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo fileParamManage.py -i fileParamReadPath ./srInfo/svcCapabilityFlavor
    EH_retOnFail

    lpReturn
}


function vis_svcCapabilityNameGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo fileParamManage.py -i fileParamReadPath ./srInfo/svcCapabilityName
    EH_retOnFail

    lpReturn
}


function vis_svcNameGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo fileParamManage.py -i fileParamReadPath ./srInfo/svcName
    EH_retOnFail

    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: SR File Params Domain Get/Set -- vis_srDomNameGet vis_srFqdnGet  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_srDomNameGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    lpDo fileParamManage.py -i fileParamReadPath ./srInfo/srDomName
    EH_retOnFail

    lpReturn
}


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
*  [[elisp:(org-cycle)][| ]]  Code          :: srcSvcBase{Logs,Data,Control,Tmp,MailDir} [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_srSvcBaseLogs {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset bxoBase=$( vis_bisoBaseGetHere )
    typeset svcCapabilityName=$( vis_svcCapabilityNameGet )
    typeset svcName=$( vis_svcNameGet )

    echo ${bxoBase}/bxp/var/logs/${svcCapabilityName}/${svcName}

    lpReturn
}


function vis_srSvcBaseData {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset bxoBase=$( vis_bisoBaseGetHere )
    typeset svcCapabilityName=$( vis_svcCapabilityNameGet )
    typeset svcName=$( vis_svcNameGet )

    echo ${bxoBase}/bxp/data/${svcCapabilityName}/${svcName}

    lpReturn
}


function vis_srSvcBaseControl {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset bxoBase=$( vis_bisoBaseGetHere )
    typeset svcCapabilityName=$( vis_svcCapabilityNameGet )
    typeset svcName=$( vis_svcNameGet )

    echo ${bxoBase}/bxp/control/${svcCapabilityName}/${svcName}

    lpReturn
}


function vis_srSvcBaseTmp {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset bxoBase=$( vis_bisoBaseGetHere )
    typeset svcCapabilityName=$( vis_svcCapabilityNameGet )
    typeset svcName=$( vis_svcNameGet )

    echo ${bxoBase}/bxp/tmp/${svcCapabilityName}/${svcName}

    lpReturn
}


function vis_srSvcBaseMailDir {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset bxoBase=$( vis_bisoBaseGetHere )
    typeset svcCapabilityName=$( vis_svcCapabilityNameGet )
    typeset svcName=$( vis_svcNameGet )

    echo ${bxoBase}/bxp/MailDir/${svcCapabilityName}/${svcName}

    lpReturn
}



_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: fullReport [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_fullReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_bisoBaseGetHere
    opDo vis_bisoSrGetHere
    opDo vis_bisoIdGetHere

    opDo vis_srDomNameGet
    opDo vis_srFqdnGet

    opDo vis_svcNameGet    
    opDo vis_svcCapabilityNameGet
    opDo vis_svcCapabilityAgentGet
    opDo vis_svcCapabilityFlavorGet        

    opDo vis_srSvcBaseLogs
    opDo vis_srSvcBaseData
    opDo vis_srSvcBaseControl
    opDo vis_srSvcBaseTmp
    opDo vis_srSvcBaseMailDir    
    
    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: srBaseStart and srBaseUpdate startObjectUpdateInCwd -- Object Method Dispatchers [[elisp:(org-cycle)][| ]]
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
            opDo bsrGenewebManage.sh -h -v -n showRun -p bpoId=${bystarUid} -p sr=${sr} -i srBaseStart
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
*  [[elisp:(org-cycle)][| ]]  Code          :: svcCapabilityFullUpdate  |  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_svcCapabilityFullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    typeset svcCapabilityAgent=$( vis_svcCapabilityAgentGet )
    typeset bpoId=$( vis_bisoIdGetHere )    
    typeset srBase=$( vis_bisoSrGetHere )

    lpDo echo ${svcCapabilityAgent} -h -v -n showRun -p bpoId=${bpoId} -p sr=${srBase} -i fullUpdate     
    EH_retOnFail

    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: -i svcCapability funcArgs  |  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_svcCapability {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -gt 0 ]]

    typeset svcCapabilityAgent=$( vis_svcCapabilityAgentGet )
    typeset bpoId=$( vis_bisoIdGetHere )    
    typeset srBase=$( vis_bisoSrGetHere )

    lpDo ${svcCapabilityAgent} -h -v -n showRun -p bpoId=${bpoId} -p sr=${srBase} -i "$@"  
    EH_retOnFail

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
