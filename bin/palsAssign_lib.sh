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


function vis_pals_registrarBaseObtain {
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

function vis_pals_registrarAssignBaseObtain {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Obtains registrar bpoId's path + "/assign"
*** Status: functional
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    local registrarBxoPath=$(vis_pals_registrarBaseObtain)
    EH_assert [ ! -z "${registrarBxoPath}" ]

    echo "${registrarBxoPath}/assign"

    lpReturn
}       


function vis_pals_withServiceTypeGetServiceLetter {
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


function vis_pals_withServiceLetterGetServiceType {
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


function vis_pals_withNuGetId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** This is just string manipulation based on naming rules.
*** Status: functional
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local palsNu="$1"

   EH_assert [ ! -z "${serviceType}" ]      

   if ! isnum ${palsNu} ; then
       EH_problem "Bad input -- Expected a number -- palsNu=${palsNu}"
       lpReturn
   fi

   local serviceLetter=$(lpDo vis_pals_withServiceTypeGetServiceLetter ${serviceType})
   
   echo "By${serviceLetter}-${palsNu}"
}


function vis_pals_withIdGetAssignedBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** palsId is something like BN-1001
*** Status: untested
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local palsId=$1

   local byStarInitial=${palsId:0:1}
   local serviceTypeInitial=${palsId:2:1}
   local palsNu=$( echo ${palsId} |  sed -e 's:...-::' ) 

   local thisServiceName=$(vis_pals_withServiceLetterGetServiceType ${serviceTypeInitial} )
   
   local registrarBase=$(vis_pals_registrarBaseObtain)
   EH_assert [ ! -z "${registrarBase}" ]

   local palsIdBase="${registrarBase}/assign/${thisServiceName}/${palsNu}"

   if [ ! -d "${palsIdBase}" ] ; then
       EH_problem "Missing palsIdBase=${palsIdBase}"
       lpReturn 101
   fi

   echo ${palsIdBase}
}


function vis_pals_withNuGetAssignedBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** With palsNu, get assigned base.
*** Status: untested
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local palsNu=$1

   local assignsBase=$(vis_pals_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]
   
   EH_assert [ ! -z "${serviceType}" ]
   
   echo "${assignsBase}/${serviceType}/${palsNu}"
}


function vis_pals_serviceTypeAssignToFpsBaseAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]

   EH_assert [ ! -z "${serviceType}" ]   
   EH_assert [ ! -z "${fpsBase}" ]

   local palsBase=$(lpDo vis_pals_serviceTypeAssignToFpsBase)
   EH_assert [ ! -z "${palsBase}" ]

   lpDo vis_pals_assignedServiceIdPush ${palsBase}
}       

function vis_pals_assignedServiceIdPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local palsBase="$1"
   EH_assert [ ! -z "${palsBase}" ]

   lpReturn
   
   lpDo eval echo ${palsBase} \| bx-gitRepos -i addCommitPush all
}       


function vis_pals_assignBasePull {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }

   EH_assert [[ $# -eq 0 ]]
   
   local registrarAssignPath=$(vis_pals_registrAssignBaseObtain)
   EH_assert [ ! -z "${registrarAssignPath}" ]
  
   lpDo eval echo ${registrarAssignBase} \| bx-gitRepos -i gitRemPull
}


function vis_pals_UnAssign {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** NOTYET, mark fpsBase as unassigned -- When to be used?
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]

   local palsBase="$1"
   EH_assert [ ! -z "${palsBase}" ]

   local fpsBaseFpPath="${palsBase}/fpsBase"
   EH_assert [ -d "${fpsBaseFpPath}" ]

   local dateTag=$( DATE_nowTag )
   lpDo cp -p ${fpsBaseFpPath}/value ${fpsBaseFpPath}/value.${dateTag}

   lpDo fileParamManage.py -i fileParamWrite "${palsBase}" fpsBase "unassigned"
}

function vis_pals_unAssignAndPush {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local palsBase="$1"
   EH_assert [ ! -z "${palsBase}" ]

   lpDo vis_pals_UnAssign "${boxId}"

   lpDo eval echo ${palsBase} \| bx-gitRepos -i addCommitPush all
}


function vis_pals_serviceTypeAssignToFpsBase {
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
           existingBase=$(lpDo vis_pals_forFpsBaseFindAssignBase ${fpsBase})
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
   
   local palsNu=$(lpDo vis_pals_assignNuGetNext)
   EH_assert [ ! -z "${palsNu}" ]   

   local palsBase=$(lpDo vis_pals_assignUpdate_atNu "${palsNu}")
   EH_assert [ ! -z "${palsBase}" ]      

   echo "${palsBase}"

   lpReturn
}       


function vis_pals_assignNuGetNext {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
** LastId +1
*** Status: Functional
_EOF_
                      }
   EH_assert [[ $# -eq 0 ]]
   EH_assert [ ! -z "${serviceType}" ]

   local assignsBase=$(vis_pals_registrarAssignBaseObtain)
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

function vis_pals_forFpsBaseFindAssignBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   
   EH_assert [[ $# -eq 1 ]]
   local fpsBase="$1"

   local assignBase=$(vis_pals_registrarAssignBaseObtain)
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


function vis_pals_assignUpdate_atNu {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local palsNu="$1"

   EH_assert [ ! -z "${fpsBase}" ]

   local serviceType="$(lpDo fileParamManage.py -i fileParamRead "${fpsBase}" serviceType)"

   local assignsBase=$(vis_pals_registrarAssignBaseObtain)
   EH_assert [ ! -z "${assignsBase}" ]

   local serviceTypeBase="${assignsBase}/${serviceType}"
   EH_assert [ -d "${serviceTypeBase}" ]

   local palsBase="${serviceTypeBase}/${palsNu}"

   if [ -d "${palsBase}" ] ; then
       ANT_raw "palsBase=${palsBase} is in place, updating"
   else
       ANT_raw "palsBase=${palsBase} missing, creating"
       lpDo mkdir -p ${palsBase}
   fi
   EH_assert [ -d "${palsBase}" ]

   local palsId=$( vis_pals_withNuGetId ${palsNu} )
   local stored_palsId=$( fileParamManage.py -i fileParamRead  ${palsBase} palsId )

   if [ -z "${stored_palsId}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${palsBase} palsId "${palsId}"
   else
       if [ "${palsId}" != "${stored_palsId}" ] ; then
           EH_problem "Expected ${palsId} -- got ${stored_palsId} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${palsBase} palsId "${palsId}"
       else
           ANT_cooked "palsId=${palsId} -- No action taken"
       fi
   fi

   local palsBpoId=pmi_$( vis_pals_withNuGetId ${palsNu} )
   local stored_palsBpoId=$( fileParamManage.py -i fileParamRead  ${palsBase} palsBpoId )

   if [ -z "${stored_palsBpoId}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${palsBase} palsBpoId "${palsBpoId}"
   else
       if [ "${palsBpoId}" != "${stored_palsBpoId}" ] ; then
           EH_problem "Expected ${palsBpoId} -- got ${stored_palsBpoId} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${palsBase} palsBpoId "${palsBpoId}"
       else
           ANT_cooked "palsBpoId=${palsBpoId} -- No action taken"
       fi
   fi


   local stored_palsNu=$( fileParamManage.py -i fileParamRead  ${palsBase} palsNu )

   if [ -z "${stored_palsNu}" ] ; then
       lpDo fileParamManage.py -i fileParamWrite ${palsBase} palsNu "${palsNu}"
   else
       if [ "${palsNu}" != "${stored_palsNu}" ] ; then
           EH_problem "Expected ${palsNu} -- got ${stored_palsNu} -- Updating it."
           lpDo fileParamManage.py -i fileParamWrite ${palsBase} palsNu "${palsNu}"
       else
           ANT_cooked "palsNu=${palsNu} -- No action taken"
       fi
   fi
   
   lpDo fileParamManage.py -i fileParamWrite ${palsBase} serviceType "${serviceType}"
   lpDo fileParamManage.py -i fileParamWrite ${palsBase} fpsBase "${fpsBase}"

   echo ${palsBase}

   lpReturn
}       

function vis_pals_withAssignBaseReadFileParam {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   
   EH_assert [[ $# -eq 2 ]]
   local assignBase="$1"
   local paramName="$2"

   local result=""

   case "${paramName}" in
       fpsBase|serviceType|palsNu|palsId|palsBpoId)
           result=$(lpDo fileParamManage.py -i fileParamRead ${assignBase} "${paramName}")
           EH_assert [ ! -z "${result}" ]
           ;;
       *)
           EH_problem "Bad Usage -- paramName=${paramName}"
           ;;
   esac

   lpDo echo "${result}"
}

function vis_pals_withAssignBaseGet_fpsBase {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_pals_withAssignBaseGet_}
   lpDo vis_pals_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_pals_withAssignBaseGet_serviceType {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_pals_withAssignBaseGet_}
   lpDo vis_pals_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_pals_withAssignBaseGet_palsNu {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_pals_withAssignBaseGet_}
   lpDo vis_pals_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_pals_withAssignBaseGet_palsId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_pals_withAssignBaseGet_}
   lpDo vis_pals_withAssignBaseReadFileParam ${assignBase} ${paramName}
}

function vis_pals_withAssignBaseGet_palsBpoId {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"
   local paramName=${FUNCNAME##vis_pals_withAssignBaseGet_}
   lpDo vis_pals_withAssignBaseReadFileParam ${assignBase} ${paramName}
}


function vis_pals_withAssignBaseReport {
   G_funcEntry
   function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                      }
   EH_assert [[ $# -eq 1 ]]
   local assignBase="$1"

   local palsId=$(vis_pals_withAssignBaseGet_palsId ${assignBase})
   
   ANT_raw "palsId=${palsId}"

   ANT_raw "${assignBase}"
   
   opDoExit pushd "${assignBase}" > /dev/null
   find . -type f -print | grep -v _tree_ | xargs egrep '^.' 
   opDoExit popd > /dev/null
    
   lpReturn
}       
