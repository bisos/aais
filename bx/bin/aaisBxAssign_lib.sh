#!/bin/bash

####+BEGIN: bx:bsip:bash/libLoadOnce :libName "auto"
if [ -z "${usgBpos_lib:-}" ] ; then
    usgBpos_lib="LOADED" ; TM_trace 7 "usgBpos_lib :: Loading Library -- /bisos/bsip/bin/usgBpos_lib.sh"
else
    TM_trace 7 "usgBpos_lib :: Prviously Loaded -- Skipping /bisos/bsip/bin/usgBpos_lib.sh" ; return
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
** Creates a BARC (Bystar Account Request Container) based on command line.
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


function vis_aabis_registrarBaseObtain {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Obtains registrar bxoId's path
*** Status: functional
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local registrarBxoId="pir_bystarRegistrar"
    
    local registrarBxoPath=$( FN_absolutePathGet ~pir_bystarRegistrar )

    EH_assert [ ! -z "${registrarBxoPath}" ]

    echo "${registrarBxoPath}"

    lpReturn
}       

function vis_aabis_registrarAssignBaseObtain {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Obtains registrar bxoId's path + "/assign"
*** Status: functional
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local registrarBxoPath=$(vis_aabis_registrarBaseObtain)
    EH_assert [ ! -z "${registrarBxoPath}" ]

    echo "${registrarBxoPath}/assign"

    lpReturn
}       


function vis_aabis_withServiceTypeGetServiceLetter {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** With \$1 as N B F etc return ServiceType
*** Status: functional
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local thisServiceType=$1
   local result=""   

   case "${thisServiceType}" in
       "ByName")
           result="N"
           ;;
       "BySmb")
           result="B"
           ;;
       "ByFamily")
           result="F"
           ;;
       "ByDomain")
           result="D"
           ;;
       *)
           EH_problem "Bad Usage -- serviceType=${thisServiceType}"
   esac
   echo ${result}
}


function vis_aabis_withServiceLetterGetServiceType {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** With \$1 as N B F etc return ServiceType
*** Status: functional
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local letter=$1
   local result=""   

   case "${letter}" in
       "N")
           result="ByName"
           ;;
       "B")
           result="BySmb"
           ;;
       "F")
           result="ByFamily"
           ;;
       "D")
           result="ByDomain"
           ;;
       *)
           EH_problem "Bad Usage -- serviceLetter=${letter}"
   esac
   echo ${result}
}


function vis_aabis_withNuGetId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** This is just string manipulation based on naming rules.
*** Status: functional
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aabisNu="$1"

   EH_assert [ ! -z "${serviceType}" ]      

   if ! isnum ${aabisNu} ; then
       EH_problem "Bad input -- Expected a number -- aabisNu=${aabisNu}"
       lpReturn
   fi

   local serviceLetter=$(lpDo vis_aabis_withServiceTypeGetServiceLetter ${serviceType})
   
   echo "By${serviceLetter}-${aabisNu}"
}


function vis_aabis_withIdGetAssignedBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** aabisId is something like BN-1001
*** Status: untested
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aabisId=$1

   local byStarInitial=${aabisId:0:1}
   local serviceTypeInitial=${aabisId:2:1}
   local aabisNu=$( echo ${aabisId} |  sed -e 's:...-::' ) 

   local thisServiceName=$(vis_aabis_withServiceLetterGetServiceType ${serviceTypeInitial} )
   
   local registrarBase=$(vis_aabis_registrarBaseObtain)
   EH_assert [ ! -z "${registrarBase}" ]

   local aabisIdBase="${registrarBase}/assign/${thisServiceName}/${aabisNu}"

   if [ ! -d "${aabisIdBase}" ] ; then
       EH_problem "Missing aabisIdBase=${aabisIdBase}"
       lpReturn 101
   fi

   echo ${aabisIdBase}
}


function vis_aabis_withNuGetAssignedBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** With aabisNu, get assigned base.
*** Status: untested
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aabisNu=$1

   local assignsBase=$(vis_aabis_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]
   
   EH_assert [ ! -z "${serviceType}" ]
   
   echo "${assignsBase}/${serviceType}/${aabisNu}"
}


function vis_aabis_serviceTypeAssignToFpsBaseAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${serviceType}" ]   
   EH_assert [ ! -z "${fpsBase}" ]

   local aabisBase=$(lpDo vis_aabis_serviceTypeAssignToFpsBase)
   EH_assert [ ! -z "${aabisBase}" ]

   lpDo vis_aabis_assignedServiceIdPush ${aabisBase}
}       

function vis_aabis_assignedServiceIdPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aabisBase="$1"
   EH_assert [ ! -z "${aabisBase}" ]

   lpReturn
   
   lpDo eval echo ${aabisBase} \| bx-gitRepos -i addCommitPush all
}       


function vis_aabis_assignBasePull {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }

   EH_assert [[ $# -eq 0 ]]
   
   local registrarAssignPath=$(vis_aabis_registrAssignBaseObtain)
   EH_assert [ ! -z "${registrarAssignPath}" ]
  
   lpDo eval echo ${registrarAssignBase} \| bx-gitRepos -i gitRemPull
}


function vis_aabis_UnAssign {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** NOTYET, mark fpsBase as unassigned -- When to be used?
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local aabisBase="$1"
   EH_assert [ ! -z "${aabisBase}" ]

   local fpsBaseFpPath="${aabisBase}/fpsBase"
   EH_assert [ -d "${fpsBaseFpPath}" ]

   local dateTag=$( DATE_nowTag )
   lpDo cp -p ${fpsBaseFpPath}/value ${fpsBaseFpPath}/value.${dateTag}

   lpDo fileParamManage.py -i fileParamWrite "${aabisBase}" fpsBase "unassigned"
}

function vis_aabis_unAssignAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aabisBase="$1"
   EH_assert [ ! -z "${aabisBase}" ]

   lpDo vis_aabis_UnAssign "${boxId}"

   lpDo eval echo ${aabisBase} \| bx-gitRepos -i addCommitPush all
}


function vis_aabis_serviceTypeAssignToFpsBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${fpsBase}" ]

   local serviceType="$(lpDo fileParamManage.py -i fileParamRead "${fpsBase}" serviceType)"

   local existingBase=""

   case "${serviceType}" in
       ByName|BySmb|ByFamily|ByDomain)
           EH_assert [ ! -z "${fpsBase}" ]
           existingBase=$(lpDo vis_aabis_forFpsBaseFindAssignBase ${fpsBase})
           ;;

       *)
           EH_problem "Bad Usage -- serviceType=${serviceType}"
           ;;
   esac


   if [ ! -z "${existingBase}" ] ; then
       if [ "${G_forceMode}" == "force" ] ; then
           ANT_raw "assignBase exists but forceMode is specified -- ${existingBase}"
       else
           echo "${existingBase}"
           lpReturn
       fi
   fi
   
   local aabisNu=$(lpDo vis_aabis_assignNuGetNext)
   EH_assert [ ! -z "${aabisNu}" ]   

   local aabisBase=$(lpDo vis_aabis_assignUpdate_atNu "${aabisNu}")
   EH_assert [ ! -z "${aabisBase}" ]      

   echo "${aabisBase}"

   lpReturn
}       


function vis_aabis_assignNuGetNext {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** LastId +1
*** Status: Functional
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]
   EH_assert [ ! -z "${serviceType}" ]

   local assignsBase=$(vis_aabis_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]

   local serviceTypeBase="${assignsBase}/${serviceType}"
   EH_assert [ -d "${serviceTypeBase}" ]
   
   opDoExit pushd "${serviceTypeBase}" > /dev/null
   local lastId=$(  ls  | sort -n | tail -1 )
   if [ -z "${lastId}" ] ; then
       lastId=100000
   fi
   opDoExit popd > /dev/null

   local nextId=$( expr ${lastId} +  1 )

   echo ${nextId}   
}

function vis_aabis_forFpsBaseFindAssignBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   
   EH_assert [[ $# -eq 1 ]]
   local fpsBase="$1"

   local assignBase=$(vis_aabis_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignBase}" ] 

   local fpsBaseIdFps=$( find ${assignBase} -type d -print | sort -n | grep fpsBase )

   local eachFpsBaseIdFp=""
   local stored_fpsBaseId=""
   local found=""

   for eachFpsBaseIdFp in ${fpsBaseIdFps} ; do
       stored_fpsBaseId=$( fileParamManage.py -i fileParamReadPath ${eachFpsBaseIdFp} )

       if [ -z "${stored_fpsBaseId}" ] ; then
           EH_problem "Missing fpsBaseId in ${eachFpsBaseIdFp} -- continuing"
           continue
       else
           if [ "${fpsBase}" == "${stored_fpsBaseId}" ] ; then
               if [ -z "${found}" ] ; then
                   found=${eachFpsBaseIdFp}
               else
                   ANT_raw "Also Found: ${eachFpsBaseIdFp}"
               fi
               #break
           fi
       fi
   done

   if [ -z "${found}" ] ; then
       echo ${found}
   else
       echo $( FN_dirsPart "${found}" )
   fi

   lpReturn
}       


function vis_aabis_assignUpdate_atNu {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aabisNu="$1"

   EH_assert [ ! -z "${fpsBase}" ]

   local serviceType="$(lpDo fileParamManage.py -i fileParamRead "${fpsBase}" serviceType)"

   local assignsBase=$(vis_aabis_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]

   local serviceTypeBase="${assignsBase}/${serviceType}"
   EH_assert [ -d "${serviceTypeBase}" ]

   local aabisBase="${serviceTypeBase}/${aabisNu}"

   if [ -d "${aabisBase}" ] ; then
       ANT_raw "aabisBase=${aabisBase} is in place, updating"
   else
       ANT_raw "aabisBase=${aabisBase} missing, creating"
       lpDo mkdir -p ${aabisBase}
   fi
   EH_assert [ -d "${aabisBase}" ]

   local aabisId=$( vis_aabis_withNuGetId ${aabisNu} )
   local stored_aabisId=$( fileParamManage.py -i fileParamRead  ${aabisBase} aabisId )

   if [ -z "${stored_aabisId}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${aabisBase} aabisId "${aabisId}"
   else
       if [ "${aabisId}" != "${stored_aabisId}" ] ; then
           EH_problem "Expected ${aabisId} -- got ${stored_aabisId} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${aabisBase} aabisId "${aabisId}"
       else
           ANT_cooked "aabisId=${aabisId} -- No action taken"
       fi
   fi

   local aabisBpoId=pmi_$( vis_aabis_withNuGetId ${aabisNu} )
   local stored_aabisBpoId=$( fileParamManage.py -i fileParamRead  ${aabisBase} aabisBpoId )

   if [ -z "${stored_aabisBpoId}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${aabisBase} aabisBpoId "${aabisBpoId}"
   else
       if [ "${aabisBpoId}" != "${stored_aabisBpoId}" ] ; then
           EH_problem "Expected ${aabisBpoId} -- got ${stored_aabisBpoId} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${aabisBase} aabisBpoId "${aabisBpoId}"
       else
           ANT_cooked "aabisBpoId=${aabisBpoId} -- No action taken"
       fi
   fi


   local stored_aabisNu=$( fileParamManage.py -i fileParamRead  ${aabisBase} aabisNu )

   if [ -z "${stored_aabisNu}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${aabisBase} aabisNu "${aabisNu}"
   else
       if [ "${aabisNu}" != "${stored_aabisNu}" ] ; then
           EH_problem "Expected ${aabisNu} -- got ${stored_aabisNu} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${aabisBase} aabisNu "${aabisNu}"
       else
           ANT_cooked "aabisNu=${aabisNu} -- No action taken"
       fi
   fi
   
   lpDo fileParamManage.py -i fileParamWrite ${aabisBase} serviceType "${serviceType}"
   lpDo fileParamManage.py -i fileParamWrite ${aabisBase} fpsBase "${fpsBase}"

   echo ${aabisBase}

   lpReturn
}       

function vis_aabis_withAssignBaseReadFileParam {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   
   EH_assert [[ $# -eq 2 ]]
   local assignBase="$1"
   local paramName="$2"

   local result=""

   case "${paramName}" in
       fpsBase|serviceType|aabisNu|aabisId|aabisBpoId)
           result=$(lpDo fileParamManage.py -i fileParamRead ${assignBase} "${paramName}")
           EH_assert [ ! -z "${result}" ]
           ;;
       *)
           EH_problem "Bad Usage -- paramName=${paramName}"
           ;;
   esac

   lpDo echo "${result}"
}

function vis_aabis_withAssignBaseGet_fpsBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aabis_withAssignBaseGet_}
   lpDo vis_aabis_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aabis_withAssignBaseGet_serviceType {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aabis_withAssignBaseGet_}
   lpDo vis_aabis_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aabis_withAssignBaseGet_aabisNu {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aabis_withAssignBaseGet_}
   lpDo vis_aabis_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aabis_withAssignBaseGet_aabisId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aabis_withAssignBaseGet_}
   lpDo vis_aabis_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aabis_withAssignBaseGet_aabisBpoId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aabis_withAssignBaseGet_}
   lpDo vis_aabis_withAssignBaseReadFileParam ${assignBase} ${paramName}
}


function vis_aabis_withAssignBaseReport {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"

   local aabisId=$(vis_aabis_withAssignBaseGet_aabisId ${assignBase})
   
   ANT_raw "aabisId=${aabisId}"

   ANT_raw "${assignBase}"
   
   opDoExit pushd "${assignBase}" > /dev/null
   find . -type f -print | grep -v _tree_ | xargs egrep '^.' 
   opDoExit popd > /dev/null
    
   lpReturn
}       
