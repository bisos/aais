#!/bin/bash

####+BEGIN: bx:bsip:bash/libLoadOnce :libName "auto"
if [ -z "${aaisRealizationFPs_lib:-}" ] ; then
    aaisRealizationFPs_lib="LOADED" ; TM_trace 7 "aaisRealizationFPs_lib :: Loading Library -- /bisos/git/auth/bxRepos/bisos/bsip4/bin/aaisRealizationFPs_lib.sh"
else
    TM_trace 7 "aaisRealizationFPs_lib :: Prviously Loaded -- Skipping /bisos/git/auth/bxRepos/bisos/bsip4/bin/aaisRealizationFPs_lib.sh" ; return
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
** Creates a FPs base for AAIS realization based on command line.
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



function vis_aais_realizationFPsRepoCreate {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** Dispatches to BoxRealize or to VirtRealize.
_EOF_
                      }
   EH_assert [[ $# -lt 2 ]]

   EH_assert bxoIdPrep

   local repoName=""
   if [ $# -eq 0 ] ; then
       repoName="realizationFPs"
   else
       repoName="$1"
   fi

   local repoBase="${bxoHome}/${repoName}"

   lpDo FN_dirCreatePathIfNotThere "${repoBase}"

   lpDo eval cat  << _EOF_  \> "${repoBase}/README.org"
BxO Repo: ${repoBase}
for now just a place holder.
_EOF_

   lpDo bx-gitRepos -h -v -n showRun -i baseUpdateDotIgnore "${repoBase}"

   lpReturn
}

function vis_aais_realizationFPsRepoPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** Dispatches to BoxRealize or to VirtRealize.
_EOF_
                      }
   EH_assert [[ $# -lt 2 ]]

   EH_assert bxoIdPrep

   local repoName=""
   if [ $# -eq 0 ] ; then
       repoName="realizationFPs"
   else
       repoName="$1"
   fi

   lpDo eval echo ${repoName} \| vis_bxoRealize_repoBasesPush

   lpReturn
}

function vis_aais_realizationFPsRepoCreateAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** Dispatches to BoxRealize or to VirtRealize.
_EOF_
                      }
   EH_assert [[ $# -lt 2 ]]

   EH_assert bxoIdPrep

   lpDo vis_aais_realizationFPsRepoCreate $@
   lpDo vis_aais_realizationFPsRepoPush $@

   lpReturn
}


function vis_realizationFPsProcess {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
**
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local action=$1

   EH_assert [ ! -z "${fpsRoot}" ]
   EH_assert [ ! -z "${serviceType}" ]

   local fpsBase=$( FN_absolutePathGet ${fpsRoot} )

   fpsBase=${fpsBase}/${serviceType}

   case "${serviceType}" in
       ByName|BySmb|ByFamily)
           EH_assert [ ! -z "${correspondingBxo}" ]
           assignBase=$(lpDo vis_aabis_serviceTypeAssignToCorrespondingBxo)
           EH_assert [ ! -z "${assignBase}" ]
           
           thisBxoId=$(lpDo vis_aabis_withAssignBaseBasicBxoRealize ${assignBase})
           EH_assert [ ! -z "${thisBxoId}" ]
           ;;
       ByDomain)
           EH_assert [ ! -z "${fqdnRoot}" ]

           lpDo fqdnToArray ${fqdnRoot}
           set ${fqdnArrayReverse[@]}

           for each in ${fqdnArrayReverse[@]} ; do
               fpsBase=${fpsBase}/${each}
           done
           ;;
       *)
           EH_problem "Bad Usage -- serviceType=${serviceType}"
           ;;
   esac

   case "${action}" in
       update)
           lpDo mkdir -p ${fpsBase}
           lpDo fileParamManage.py -i fileParamWrite "${fpsBase}" serviceType "${serviceType}"
           lpDo fileParamManage.py -i fileParamWrite "${fpsBase}" fqdnRoot "${fqdnRoot}"
           lpDo fileParamManage.py -i fileParamWrite "${fpsBase}" updateDate "$(date)"
           ;;
       fpsBase)
           lpDo echo ${fpsBase}
           ;;
       readDeep)
           lpDo fileParamManage.py -i fileParamDictReadDeep ${fpsBase}
           ;;
       *)
           EH_problem "Bad Usage -- action=${action}"
           ;;
   esac
}


function vis_aabis_withAssignBaseGetBxoId%% {
        G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** \$1 is bxoRepoScope -- \$2 is path to siteAabisAssignBase 
*** -p passive= instead of  EH_assert bxoRealizationScopeIsValid "${bxoRealizationScope}"
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local aabisAssignBase=$1
   EH_assert [ -d ${aabisAssignBase} ]

   echo "$(vis_aabis_withAssignBaseGet_aabisBpoId ${aabisAssignBase})"
}

function vis_aabis_withAssignBaseBasicBxoRealize {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** \$1 is bxoRepoScope -- \$2 is path to siteAabisAssignBase 
*** -p passive= instead of  EH_assert bxoRealizationScopeIsValid "${bxoRealizationScope}"
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local aabisAssignBase=$1
   EH_assert [ -d ${aabisAssignBase} ]

   local bxoRealizationScope="full" # NOTYET
   
   #local aabisBxoId=$(vis_aabis_withAssignBaseGetBxoId "${aabisAssignBase}" )
   local aabisBxoId=$(vis_aabis_withAssignBaseGet_aabisBpoId "${aabisAssignBase}")
   EH_assert [ ! -z "${aabisBxoId}" ]

   local parentBxoId=$(vis_aabis_withAssignBaseGet_correspondingBxo "${aabisAssignBase}")
   
   local aabisId=$(vis_aabis_withAssignBaseGet_aabisId ${aabisAssignBase})  # used as name for provisioning

   if vis_bxoAcctVerify "${aabisBxoId}" ; then
       ANT_raw "${aabisBxoId} account exists, already realized -- provisioning skipped"
   else
       ANT_raw "${aabisBxoId} will be realized"       
       lpDo bxmeProvision.sh -h -v -n showRun -p privacy="priv" -p kind="materialization" -p type="aais" -p parent="${parentBxoId}" -p name="${aabisId}" -i startToPrivRealize ${bxoRealizationScope}
   fi

   bxoId="${aabisBxoId}"
   EH_assert vis_bxoAcctVerify "${bxoId}"

   echo "${bxoId}"
}

function vis_aabis_repoBasesList {
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

function vis_aabis_nonRepoBasesList {
    cat  << _EOF_
var
_EOF_
}

function vis_aabis_repoBasesAllCreate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** 
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    lpDo eval vis_aabis_repoBasesList \| vis_bxoRealize_repoBasesCreate aabis
}       

function vis_aabis_repoBasesAllPush {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** 
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    lpDo eval vis_aabis_repoBasesList \| vis_bxoRealize_repoBasesPush
}       

function vis_aabis_nonRepoBasesAllCreate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** 
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    lpDo eval vis_aabis_nonRepoBasesList \| vis_bxoRealize_nonRepoBasesCreate aabis
}       


function vis_aabis_nonRepoBaseCreate_var {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Create /bisos/var/bxoId/${bxoId} and symlink to it.
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    local baseName=${FUNCNAME##vis_aabis_nonRepoBaseCreate_}
    local basePath="${bxoHome}/${baseName}"
    
    local bisosVarBaseDir="/bisos/var/bxoId/${bxoId}"

    lpDo FN_dirCreatePathIfNotThere ${bisosVarBaseDir}
    
    lpDo FN_fileSymlinkUpdate ${bisosVarBaseDir} ${basePath}

    lpReturn
}       

function vis_aabis_repoBaseCreate_panel { vis_repoBaseCreate_panel; }

function vis_aabis_repoBaseCreate_BAGP {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    local repoName=${FUNCNAME##vis_aabis_repoBaseCreate_}
    local repoBase="${bxoHome}/${repoName}"

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

function vis_aabis_repoBaseCreate_NSP {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    local repoName=${FUNCNAME##vis_aabis_repoBaseCreate_}
    local repoBase="${bxoHome}/${repoName}"

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

function vis_aabis_repoBaseCreate_par_live {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    #local repoName=${FUNCNAME##vis_aabis_repoBaseCreate_}
    local repoName=par.live
    local repoBase="${bxoHome}/${repoName}"

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
