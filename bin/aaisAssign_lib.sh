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


function vis_aais_registrarBaseObtain {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Obtains registrar bpoId's path
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

function vis_aais_registrarAssignBaseObtain {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Obtains registrar bpoId's path + "/assign"
*** Status: functional
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local registrarBxoPath=$(vis_aais_registrarBaseObtain)
    EH_assert [ ! -z "${registrarBxoPath}" ]

    echo "${registrarBxoPath}/assign"

    lpReturn
}       


function vis_aais_withServiceTypeGetServiceLetter {
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


function vis_aais_withServiceLetterGetServiceType {
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


function vis_aais_withNuGetId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** This is just string manipulation based on naming rules.
*** Status: functional
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aaisNu="$1"

   EH_assert [ ! -z "${serviceType}" ]      

   if ! isnum ${aaisNu} ; then
       EH_problem "Bad input -- Expected a number -- aaisNu=${aaisNu}"
       lpReturn
   fi

   local serviceLetter=$(lpDo vis_aais_withServiceTypeGetServiceLetter ${serviceType})
   
   echo "By${serviceLetter}-${aaisNu}"
}


function vis_aais_withIdGetAssignedBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** aaisId is something like BN-1001
*** Status: untested
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aaisId=$1

   local byStarInitial=${aaisId:0:1}
   local serviceTypeInitial=${aaisId:2:1}
   local aaisNu=$( echo ${aaisId} |  sed -e 's:...-::' ) 

   local thisServiceName=$(vis_aais_withServiceLetterGetServiceType ${serviceTypeInitial} )
   
   local registrarBase=$(vis_aais_registrarBaseObtain)
   EH_assert [ ! -z "${registrarBase}" ]

   local aaisIdBase="${registrarBase}/assign/${thisServiceName}/${aaisNu}"

   if [ ! -d "${aaisIdBase}" ] ; then
       EH_problem "Missing aaisIdBase=${aaisIdBase}"
       lpReturn 101
   fi

   echo ${aaisIdBase}
}


function vis_aais_withNuGetAssignedBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** With aaisNu, get assigned base.
*** Status: untested
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aaisNu=$1

   local assignsBase=$(vis_aais_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]
   
   EH_assert [ ! -z "${serviceType}" ]
   
   echo "${assignsBase}/${serviceType}/${aaisNu}"
}


function vis_aais_serviceTypeAssignToFpsBaseAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${serviceType}" ]   
   EH_assert [ ! -z "${fpsBase}" ]

   local aaisBase=$(lpDo vis_aais_serviceTypeAssignToFpsBase)
   EH_assert [ ! -z "${aaisBase}" ]

   lpDo vis_aais_assignedServiceIdPush ${aaisBase}
}       

function vis_aais_assignedServiceIdPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aaisBase="$1"
   EH_assert [ ! -z "${aaisBase}" ]

   lpReturn
   
   lpDo eval echo ${aaisBase} \| bx-gitRepos -i addCommitPush all
}       


function vis_aais_assignBasePull {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }

   EH_assert [[ $# -eq 0 ]]
   
   local registrarAssignPath=$(vis_aais_registrAssignBaseObtain)
   EH_assert [ ! -z "${registrarAssignPath}" ]
  
   lpDo eval echo ${registrarAssignBase} \| bx-gitRepos -i gitRemPull
}


function vis_aais_UnAssign {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** NOTYET, mark fpsBase as unassigned -- When to be used?
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local aaisBase="$1"
   EH_assert [ ! -z "${aaisBase}" ]

   local fpsBaseFpPath="${aaisBase}/fpsBase"
   EH_assert [ -d "${fpsBaseFpPath}" ]

   local dateTag=$( DATE_nowTag )
   lpDo cp -p ${fpsBaseFpPath}/value ${fpsBaseFpPath}/value.${dateTag}

   lpDo fileParamManage.py -i fileParamWrite "${aaisBase}" fpsBase "unassigned"
}

function vis_aais_unAssignAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aaisBase="$1"
   EH_assert [ ! -z "${aaisBase}" ]

   lpDo vis_aais_UnAssign "${boxId}"

   lpDo eval echo ${aaisBase} \| bx-gitRepos -i addCommitPush all
}


function vis_aais_serviceTypeAssignToFpsBase {
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
           existingBase=$(lpDo vis_aais_forFpsBaseFindAssignBase ${fpsBase})
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
   
   local aaisNu=$(lpDo vis_aais_assignNuGetNext)
   EH_assert [ ! -z "${aaisNu}" ]   

   local aaisBase=$(lpDo vis_aais_assignUpdate_atNu "${aaisNu}")
   EH_assert [ ! -z "${aaisBase}" ]      

   echo "${aaisBase}"

   lpReturn
}       


function vis_aais_assignNuGetNext {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** LastId +1
*** Status: Functional
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]
   EH_assert [ ! -z "${serviceType}" ]

   local assignsBase=$(vis_aais_registrarAssignBaseObtain)
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

function vis_aais_forFpsBaseFindAssignBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   
   EH_assert [[ $# -eq 1 ]]
   local fpsBase="$1"

   local assignBase=$(vis_aais_registrarAssignBaseObtain)
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


function vis_aais_assignUpdate_atNu {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local aaisNu="$1"

   EH_assert [ ! -z "${fpsBase}" ]

   local serviceType="$(lpDo fileParamManage.py -i fileParamRead "${fpsBase}" serviceType)"

   local assignsBase=$(vis_aais_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]

   local serviceTypeBase="${assignsBase}/${serviceType}"
   EH_assert [ -d "${serviceTypeBase}" ]

   local aaisBase="${serviceTypeBase}/${aaisNu}"

   if [ -d "${aaisBase}" ] ; then
       ANT_raw "aaisBase=${aaisBase} is in place, updating"
   else
       ANT_raw "aaisBase=${aaisBase} missing, creating"
       lpDo mkdir -p ${aaisBase}
   fi
   EH_assert [ -d "${aaisBase}" ]

   local aaisId=$( vis_aais_withNuGetId ${aaisNu} )
   local stored_aaisId=$( fileParamManage.py -i fileParamRead  ${aaisBase} aaisId )

   if [ -z "${stored_aaisId}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${aaisBase} aaisId "${aaisId}"
   else
       if [ "${aaisId}" != "${stored_aaisId}" ] ; then
           EH_problem "Expected ${aaisId} -- got ${stored_aaisId} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${aaisBase} aaisId "${aaisId}"
       else
           ANT_cooked "aaisId=${aaisId} -- No action taken"
       fi
   fi

   local aaisBpoId=pmi_$( vis_aais_withNuGetId ${aaisNu} )
   local stored_aaisBpoId=$( fileParamManage.py -i fileParamRead  ${aaisBase} aaisBpoId )

   if [ -z "${stored_aaisBpoId}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${aaisBase} aaisBpoId "${aaisBpoId}"
   else
       if [ "${aaisBpoId}" != "${stored_aaisBpoId}" ] ; then
           EH_problem "Expected ${aaisBpoId} -- got ${stored_aaisBpoId} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${aaisBase} aaisBpoId "${aaisBpoId}"
       else
           ANT_cooked "aaisBpoId=${aaisBpoId} -- No action taken"
       fi
   fi


   local stored_aaisNu=$( fileParamManage.py -i fileParamRead  ${aaisBase} aaisNu )

   if [ -z "${stored_aaisNu}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${aaisBase} aaisNu "${aaisNu}"
   else
       if [ "${aaisNu}" != "${stored_aaisNu}" ] ; then
           EH_problem "Expected ${aaisNu} -- got ${stored_aaisNu} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${aaisBase} aaisNu "${aaisNu}"
       else
           ANT_cooked "aaisNu=${aaisNu} -- No action taken"
       fi
   fi
   
   lpDo fileParamManage.py -i fileParamWrite ${aaisBase} serviceType "${serviceType}"
   lpDo fileParamManage.py -i fileParamWrite ${aaisBase} fpsBase "${fpsBase}"

   echo ${aaisBase}

   lpReturn
}       

function vis_aais_withAssignBaseReadFileParam {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   
   EH_assert [[ $# -eq 2 ]]
   local assignBase="$1"
   local paramName="$2"

   local result=""

   case "${paramName}" in
       fpsBase|serviceType|aaisNu|aaisId|aaisBpoId)
           result=$(lpDo fileParamManage.py -i fileParamRead ${assignBase} "${paramName}")
           EH_assert [ ! -z "${result}" ]
           ;;
       *)
           EH_problem "Bad Usage -- paramName=${paramName}"
           ;;
   esac

   lpDo echo "${result}"
}

function vis_aais_withAssignBaseGet_fpsBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aais_withAssignBaseGet_}
   lpDo vis_aais_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aais_withAssignBaseGet_serviceType {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aais_withAssignBaseGet_}
   lpDo vis_aais_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aais_withAssignBaseGet_aaisNu {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aais_withAssignBaseGet_}
   lpDo vis_aais_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aais_withAssignBaseGet_aaisId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aais_withAssignBaseGet_}
   lpDo vis_aais_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_aais_withAssignBaseGet_aaisBpoId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_aais_withAssignBaseGet_}
   lpDo vis_aais_withAssignBaseReadFileParam ${assignBase} ${paramName}
}


function vis_aais_withAssignBaseReport {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"

   local aaisId=$(vis_aais_withAssignBaseGet_aaisId ${assignBase})
   
   ANT_raw "aaisId=${aaisId}"

   ANT_raw "${assignBase}"
   
   opDoExit pushd "${assignBase}" > /dev/null
   find . -type f -print | grep -v _tree_ | xargs egrep '^.' 
   opDoExit popd > /dev/null
    
   lpReturn
}       
