#!/bin/bash

IimBriefDescription="Autonomy Asirtible Internet Service -- ByName -- Realize"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
### Args: :control "enabled|disabled|hide|release|fVar"  :vc "cvs|git|nil" :partof "bystar|nil" :copyleft "halaal+minimal|halaal+brief|nil"
typeset RcsId="$Id: dblock-iim-bash.el,v 1.4 2017-02-08 06:42:32 lsipusr Exp $"
# *CopyLeft*
__copying__="
* Libre-Halaal Software"
#  This is part of ByStar Libre Services. http://www.by-star.net
# Copyright (c) 2011 Neda Communications, Inc. -- http://www.neda.com
# See PLPC-120001 for restrictions.
# This is a Halaal Poly-Existential intended to remain perpetually Halaal.
####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/core/bsip/bin/bxeRealize.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
fi
####+END:

_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
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
*  [[elisp:(org-cycle)][| ]]  Xrefs         :: *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Panel        :: [[file:/bisos/panels/bisos/core/bxeAndBxo/_nodeBase_/fullUsagePanel-en.org::Panel][Panel Roadmap Documentation]] [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Info          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]

_EOF_
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *Seed Extensions*
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Imports       :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/bxoId_lib.sh

. ${opBinBase}/bxeDesc_lib.sh

. ${opBinBase}/bystarHook.libSh

. ${opBinBase}/bystarLib.sh

. ${opBinBase}/lcnFileParams.libSh

# . ${opBinBase}/bystarInfoBase.libSh

. ${opBinBase}/platformBases_lib.sh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh

. ${opBinBase}/bxioCommon_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/site_lib.sh

. ${opBinBase}/l3_lib.sh
. ${opBinBase}/sysChar_lib.sh

. ${opBinBase}/siteNetworks_lib.sh

. ${aabisBinBase}/aabisAssign_lib.sh
. ${aabisBinBase}/aabisRealize_lib.sh

# PRE parameters

typeset -t bxoId=""

typeset -t fpsBase=""


function G_postParamHook {
    bxoIdPrepValidate    

    if [ ! -z "${bxoId}" ] ; then
        bxoHome=$( FN_absolutePathGet ~${bxoId} )
    fi
    
    bisosCurrentsGet
}


noArgsHook() {
  vis_examples
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Examples      :: Examples [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    typeset runInfo="-p ri=lsipusr:passive"

    typeset examplesInfo="${extraInfo} ${runInfo}"

    oneBxoRepoScope="basePrep"

    local oneFpsBase=$(aabisRealizationFPs.sh -p fpsRoot="~pip_aaisDevExamples/realizationFPs" -p serviceType=ByDomain -p fqdnRoot=example.com -i realizationFPsProcess fpsBase)

    local fpsBase="${oneFpsBase}"
    local oneBxoId="$(vis_aabis_assignAndGetBxoId)"
    local oneAssignBase=$(vis_aabis_forFpsBaseFindAssignBase ${oneFpsBase})


    function repoBaseCreateAndPushExamples {
        EH_assert [[ $# -eq 2 ]]
        local repoName=$1
        local description=$2
        cat  << _EOF_
$( examplesSeperatorSubSection "${description}" )
${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i aabis_repoBaseCreate_${repoName}
${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i bxoRealize_repoBasesPush ${repoName}
_EOF_
    }   

    function nonRepoBaseCreateAndPushExamples {
        EH_assert [[ $# -eq 2 ]]
        local repoName=$1
        local description=$2
        cat  << _EOF_
$( examplesSeperatorSubSection "${description}" )
${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i aabis_nonRepoBaseCreate_${repoName}
_EOF_
    }   

    
    visLibExamplesOutput ${G_myName}
    
    cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
bisosCurrentsManage.sh
bisosCurrentsManage.sh  ${extraInfo} -i setParam currentBxoId "${oneBxoId}"
_EOF_
    
    cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "ByStar AAIS Assign And BPO Realize" )
${G_myName} ${extraInfo} -p fpsBase=${oneFpsBase} -i aabis_assignAndBasicBxoRealize  # BASIC ACTION -- PRIMARY COMMAND
${G_myName} ${extraInfo} -p fpsBase=${oneFpsBase} -i aabis_assignAndFullRealize  # FULL ACTION -- PRIMARY COMMAND
$( examplesSeperatorChapter "Obtain BpoId" )
${G_myName} ${extraInfo} -p fpsBase=${oneFpsBase} -i aabis_assignAndGetBxoId
${G_myName} ${extraInfo} -i aabis_withAssignBaseGetBxoId ${oneAssignBase}
_EOF_

    cat  << _EOF_
$( examplesSeperatorChapter "Specific Initial Repo Realizition" )
$( examplesSeperatorSection "Repo Bases List And Create -- Realizition" )
${G_myName} ${extraInfo} -i aabis_repoBasesList
${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i aabis_repoBasesAllCreate
${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i aabis_repoBasesAllPush
${G_myName} -i aabis_repoBasesList | ${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i bxoRealize_repoBasesCreate aabis
$( repoBaseCreateAndPushExamples panel "Panel Repo (Basic Panel)" )
$( repoBaseCreateAndPushExamples BAGP "Repo" )
$( repoBaseCreateAndPushExamples NSP "Repo" )
$( repoBaseCreateAndPushExamples par_live "Repo" )
$( examplesSeperatorSection "Non Repo Bases List And Create -- Realizition" )
${G_myName} ${extraInfo} -i aabis_nonRepoBasesList
${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i aabis_nonRepoBasesAllCreate
${G_myName} -i aabis_nonRepoBasesList | ${G_myName} ${extraInfo} -p bxoId="${oneBxoId}" -i bxoRealize_nonRepoBasesCreate aabis
$( nonRepoBaseCreateAndPushExamples var "Var BaseDir Link" )
_EOF_

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
