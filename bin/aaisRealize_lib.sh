#!/bin/bash

####+BEGIN: bx:bsip:bash/libLoadOnce :libName "auto"
if [ -z "${aaisByStarRealize_lib:-}" ] ; then
    aaisByStarRealize_lib="LOADED" ; TM_trace 7 "aaisByStarRealize_lib :: Loading Library -- /bisos/bsip/bin/aaisByStarRealize_lib.sh"
else
    TM_trace 7 "aaisByStarRealize_lib :: Prviously Loaded -- Skipping /bisos/bsip/bin/aaisByStarRealize_lib.sh" ; return
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
**  [[elisp:(org-cycle)][| ]]  Panel        :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]] [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Info          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]
** 
** Creates a BARC (Bystar Account Request Aabis) based on command line.
** E|
_EOF_
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *Seed Extensions*
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Imports       :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  IIFs          :: Interactively Invokable Functions (IIF)s |  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_aais_byname_assignAndRealize { serviceType=ByName; lpDo vis_aais_assignAndRealize; }


function vis_aais_assignAndFullRealize {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** Dispatches to BoxRealize or to VirtRealize.
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${fpsBase}" ]

   # Realize a new BxO based on fpsBase
   # 
   local thisBxo=$(lpDo vis_aais_assignAndBasicBxoRealize)
   EH_assert [ ! -z "${thisBxo}" ]

   lpDo bpoIdPrep ${thisBxo}
   bpoId=${thisBxo}
   
   # vis_aais_nonRepoBasesFullCreate should be run before vis_aais_repoBasesFullCreate
   #
   lpDo vis_aais_nonRepoBasesAllCreate # Creates symlinks in ~bxo   

   lpDo vis_aais_repoBasesAllCreate
   lpDo vis_aais_repoBasesAllPush   
}       


function vis_aais_assignAndBasicBxoRealize {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** Dispatches to BoxRealize or to VirtRealize.
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${fpsBase}" ]

   local serviceType="$(lpDo fileParamManage.py -i fileParamRead "${fpsBase}" serviceType)"

   local assignBase=""
   local thisBxoId=""
   
   case "${serviceType}" in
       ByName|BySmb|ByFamily|ByDomain)
           EH_assert [ ! -z "${fpsBase}" ]
           assignBase=$(lpDo vis_aais_serviceTypeAssignToFpsBase)
           EH_assert [ ! -z "${assignBase}" ]
           
           thisBxoId=$(lpDo vis_aais_withAssignBaseBasicBxoRealize ${assignBase})
           EH_assert [ ! -z "${thisBxoId}" ]
           ;;
       *)
           EH_problem "Bad Usage -- serviceType=${serviceType}"
           ;;
   esac

   echo "${thisBxoId}"
}       

function vis_aais_assignAndGetBxoId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
**
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${fpsBase}" ]

   local serviceType="$(lpDo fileParamManage.py -i fileParamRead "${fpsBase}" serviceType)"

   local assignBase=""
   local thisBxoId=""

   case "${serviceType}" in
       ByName|BySmb|ByFamily|ByDomain)
           EH_assert [ ! -z "${fpsBase}" ]
           assignBase=$(lpDo vis_aais_serviceTypeAssignToFpsBase)
           EH_assert [ ! -z "${assignBase}" ]

           thisBxoId=$(lpDo vis_aais_withAssignBaseGetBxoId ${assignBase})
           EH_assert [ ! -z "${thisBxoId}" ]
           ;;
       *)
           EH_problem "Bad Usage -- serviceType=${serviceType}"
           ;;
   esac

   echo "${thisBxoId}"
}


function vis_aais_withAssignBaseGetBxoId {
        G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** \$1 is bxoRepoScope -- \$2 is path to siteAabisAssignBase 
*** -p passive= instead of  EH_assert bxoRealizationScopeIsValid "${bxoRealizationScope}"
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local aaisAssignBase=$1
   EH_assert [ -d ${aaisAssignBase} ]

   echo "$(vis_aais_withAssignBaseGet_aaisBpoId ${aaisAssignBase})"
}

function vis_aais_withAssignBaseBasicBxoRealize {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** \$1 is bxoRepoScope -- \$2 is path to siteAabisAssignBase 
*** -p passive= instead of  EH_assert bxoRealizationScopeIsValid "${bxoRealizationScope}"
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local aaisAssignBase=$1
   EH_assert [ -d ${aaisAssignBase} ]

   local bxoRealizationScope="full" # NOTYET
   
   local aaisBxoId=$(vis_aais_withAssignBaseGetBxoId "${aaisAssignBase}" )
   EH_assert [ ! -z "${aaisBxoId}" ]

   local fpsBase=$(vis_aais_withAssignBaseGet_fpsBase "${aaisAssignBase}")
   local parentBxoId=$(lpDo bpoReposManage.sh -i bpoIdObtainForPath ${fpsBase})
   
   local aaisId=$(vis_aais_withAssignBaseGet_aaisId ${aaisAssignBase})  # used as name for provisioning

   if vis_bxoAcctVerify "${aaisBxoId}" ; then
       ANT_raw "${aaisBxoId} account exists, already realized -- provisioning skipped"
   else
       ANT_raw "${aaisBxoId} will be realized"       
       lpDo bxmeProvision.sh -h -v -n showRun -p privacy="priv" -p kind="materialization" -p type="aais" -p parent="${parentBxoId}" -p name="${aaisId}" -i startToPrivRealize ${bxoRealizationScope}
   fi

   bpoId="${aaisBxoId}"
   EH_assert vis_bxoAcctVerify "${bpoId}"

   echo "${bpoId}"
}

function vis_aais_repoBasesList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    cat  << _EOF_
panel
BAGP
NSP
par_live
_EOF_

    lpReturn
}

function vis_aais_nonRepoBasesList {
    cat  << _EOF_
var
_EOF_
}

function vis_aais_repoBasesAllCreate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** 
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    lpDo eval vis_aais_repoBasesList \| vis_bxoRealize_repoBasesCreate aais
}       

function vis_aais_repoBasesAllPush {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** 
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    lpDo eval vis_aais_repoBasesList \| vis_bxoRealize_repoBasesPush
}       

function vis_aais_nonRepoBasesAllCreate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** 
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    lpDo eval vis_aais_nonRepoBasesList \| vis_bxoRealize_nonRepoBasesCreate aais
}       


function vis_aais_nonRepoBaseCreate_var {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Create /bisos/var/bpoId/${bpoId} and symlink to it.
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    local baseName=${FUNCNAME##vis_aais_nonRepoBaseCreate_}
    local basePath="${bpoHome}/${baseName}"
    
    local bisosVarBaseDir="/bisos/var/bpoId/${bpoId}"

    lpDo FN_dirCreatePathIfNotThere ${bisosVarBaseDir}
    
    lpDo FN_fileSymlinkUpdate ${bisosVarBaseDir} ${basePath}

    lpReturn
}       

function vis_aais_repoBaseCreate_panel { vis_repoBaseCreate_panel; }

function vis_aais_repoBaseCreate_BAGP {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    local repoName=${FUNCNAME##vis_aais_repoBaseCreate_}
    local repoBase="${bpoHome}/${repoName}"

    lpDo FN_dirCreatePathIfNotThere "${repoBase}"

    lpDo eval cat  << _EOF_  \> "${repoBase}/README.org"    
BxO Repo: ${repoBase} 
for now just a bin directory
_EOF_

    # vis_sysCharWrite is in ./sysChar_lib.sh 
    #lpDo vis_sysCharWrite

    lpDo bx-gitRepos -h -v -n showRun -i baseUpdateDotIgnore "${repoBase}"

    lpReturn
}       

function vis_aais_repoBaseCreate_NSP {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    local repoName=${FUNCNAME##vis_aais_repoBaseCreate_}
    local repoBase="${bpoHome}/${repoName}"

    lpDo FN_dirCreatePathIfNotThere "${repoBase}"

    lpDo eval cat  << _EOF_  \> "${repoBase}/README.org"    
BxO Repo: ${repoBase} 
for now just a bin directory
_EOF_

    # vis_sysCharWrite is in ./sysChar_lib.sh 
    #lpDo vis_sysCharWrite

    lpDo bx-gitRepos -h -v -n showRun -i baseUpdateDotIgnore "${repoBase}"

    lpReturn
}       

function vis_aais_repoBaseCreate_par_live {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    #local repoName=${FUNCNAME##vis_aais_repoBaseCreate_}
    local repoName=par.live
    local repoBase="${bpoHome}/${repoName}"

    lpDo FN_dirCreatePathIfNotThere "${repoBase}"

    lpDo eval cat  << _EOF_  \> "${repoBase}/README.org"    
BxO Repo: ${repoBase} 
for now just a bin directory
_EOF_

    # vis_sysCharWrite is in ./sysChar_lib.sh 
    #lpDo vis_sysCharWrite

    lpDo bx-gitRepos -h -v -n showRun -i baseUpdateDotIgnore "${repoBase}"

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
