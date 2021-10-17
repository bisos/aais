# -*- mode: sh; -*-

# see bystarAcctInfo.sh for the paradigm

function loadSiParams {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
                       }
    EH_assert [[ $# -eq 2 ]]
    local thisBpoId="$1"
    local thisSi="$2"

    local tmpFile=/tmp/$$.JJ

    lpDo eval siPlone3.py --bpoId=${thisBpoId} --si=${thisSi} -i siToBxBash \> ${tmpFile}

    lpDo source  ${tmpFile}

    lpDo rm ${tmpFile}

    #echo ${cp_acctNu}
}



function bpoIdHerePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Returns none-zero for assertion 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    case ${bpoId} in
      "")
            EH_problem "bpoId=\"\" -- empty/blank -- invalid bpoId"
            lpReturn 101
            ;;
      "INVALID"|"MANDATORY")
            EH_problem "bpoId=${bpoId} -- empty/blank -- invalid bpoId"
            lpReturn 101
            ;;
      "current")
            lpCurrentsGet
            if [ "${currentBystarUid}" != "" ] ; then
                bpoId=${currentBystarUid}
            else
                EH_problem "bpoId=current But current is unset -- invalid bpoId"
                lpReturn 101
            fi  
            ;;
      "prompt")
            echo -n "Specify bpoId: "
            read bpoId
            ;;
      "default")   # e.g., first applicable entry in /etc/passwd
            doNothing
            ;;  
      "all")
            doNothing
            ;;  
        *)
            doNothing
            ;;
    esac

    bpoIdHereIsValid
    EH_retOnFail

    lpReturn 0
}

function bpoIdHereIsValid {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    case ${bpoId} in
      "all")
            lpReturn 0
            ;;
        *)
            doNothing
    esac

    if ! opAcct_IsUserValid ${bpoId}  ; then
        EH_problem "Acct ${bpoId} does not exists on system -- Invalid Acct"
        lpReturn 101
    fi

    lpReturn 0
}


function bystarAcctTargetModePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
arg1 (mode) Valid values are: "here" | "live"
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    typeset thisMode=$1

    case ${thisMode} in
        "here")
            doNothing
            ;;
        "live")
            doNothing
            ;;
        "")
            EH_problem "mode=\"\" -- empty/blank -- invalid mode"
            lpReturn 101
            ;;
        "local")
            EH_problem "mode=${thisMode} -- Obsoleted -- invalid mode"
            lpReturn 101
            ;;
        "world")
            EH_problem "mode=${thisMode} -- Obsoleted -- invalid mode"
            lpReturn 101
            ;;
        *)
            EH_problem "mode=${thisMode} -- Unknown -- invalid mode"
            lpReturn 101
            ;;
    esac

    lpReturn 0
}



typeset bystarHereAnalyzeAcct_hasRun=""
function bystarHereAnalyzeAcct {
  thisFuncName=$( thisFuncNameBashOrKsh "$0" "$FUNCNAME" )
  beIdempotent
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bpoIdHome=$( FN_absolutePathGet ~${bpoId} )
  bpoIdGroupName=$( id -n -g ${bpoId} )
  bpoIdNu=$( id -u ${bpoId} )

  bystar_acct_acctTypePrefix=${bpoId%%-*}


    case ${bystar_acct_acctTypePrefix} in 
      "ea")
            bystarServiceType="BYSMB"
            bystarServiceSupportType="COMMITTED"
            ;;
      "ma")
            bystarServiceType="BYMEMORY"
            bystarServiceSupportType="COMMITTED"
            ;;
      "mu")
            bystarServiceType="BYMEMORY"
            bystarServiceSupportType="TRIAL"
            ;;
      "sa")
            bystarServiceType="BYNAME"
            bystarServiceSupportType="COMMITTED"
            ;;
      "ua")
            bystarServiceType="BYNAME"
            bystarServiceSupportType="TRIAL"
            ;;
      "aa")
            bystarServiceType="BYALIAS"
            bystarServiceSupportType="COMMITTED"
            ;;
      "au")
            bystarServiceType="BYALIAS"
            bystarServiceSupportType="TRIAL"
            ;;
      "ca")
            bystarServiceType="BCA"
            bystarServiceSupportType="COMMITTED"
            ;;
        *)
            EH_problem "Unknown ${bystar_acct_acctTypePrefix}"
            return 101
    esac
}


typeset bystarHereAnalyzeAcctBag_hasRun=""
function bystarHereAnalyzeAcctBagp {
  thisFuncName=$( thisFuncNameBashOrKsh "$0" "$FUNCNAME" )
  beIdempotent
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bystarHereAnalyzeAcct

  bystarBagpLoad

  ### bystarAcctPasswdGet
  thisKey=$( STR_toLower ${cp_ServiceType} )
  bpoIdPasswdDecrypted=$(  echo ${cp_currentPasswd}  | gcipher -C Vigenere -k ${thisKey} - )
}

typeset bystarHereAnalyzeAcctBagDomForms_hasRun=""
function bystarHereAnalyzeAcctBagpDomForms {
  thisFuncName=$( thisFuncNameBashOrKsh "$0" "$FUNCNAME" )
  beIdempotent
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bystarHereAnalyzeAcctBagp

  infoBaseAcctBase="${infoBaseAcctCurrent}/${bpoId}"

  #if [ ! -d ${infoBaseAcctBase} ] ; then
      #opDoExit mkdir -p ${infoBaseAcctBase}
  #fi

  #
  # NOTYET, Schema Part Needs to be separated from Central Info
  #
  
  bystarDomainFormsPrep  2> /dev/null
}


function bystarTargetModeGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bpoIdHome=$( FN_absolutePathGet ~${bpoId} )

  if [ -f  ${bpoIdHome}/par.live/targetMode.novc ] ; then
      typeset thisTargetMode=$( cat ${bpoIdHome}/par.live/targetMode.novc )
      echo ${thisTargetMode}
  else
      echo ""
  fi
}    
   
function vis_hereContainerPlone3ParamCapture {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 
This should be run once at installation.
And everytime that the plone site passwd is changed. 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn 1; fi;
    
    typeset userNameCapture=$( grep Username: /usr/local/Plone/zeocluster/adminPassword.txt | cut -d ":" -f 2 )
    typeset passwordCapture=$( grep Password: /usr/local/Plone/zeocluster/adminPassword.txt | cut -d ":" -f 2 )

    if [ -z "${userNameCapture}" ] ; then
        EH_problem "Empty Username"
        lpReturn 101
    fi

    if [ -z "${passwordCapture}" ] ; then
        EH_problem "Empty Password"
        lpReturn 101
    fi

    opDo eval "echo ${userNameCapture} > /libre/etc/platform/lcaPlone/platformPloneAdminUser"
    opDo eval "echo ${passwordCapture} > /libre/etc/platform/lcaPlone/platformPloneAdminPasswd"
}

function vis_hereContainerPlone3UserGet {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if [ -s  /libre/etc/platform/lcaPlone/platformPloneAdminUser ] ; then
        cat /libre/etc/platform/lcaPlone/platformPloneAdminUser
    else
        EH_problem "Missing or Empty: /libre/etc/platform/lcaPlone/platformPloneAdminUser"
    fi
}

function vis_hereContainerPlone3PasswdGet {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]


    if [ -s  /libre/etc/platform/lcaPlone/platformPloneAdminPasswd ] ; then
        cat /libre/etc/platform/lcaPlone/platformPloneAdminPasswd
    else
        EH_problem "Missing or Empty: /libre/etc/platform/lcaPlone/platformPloneAdminPasswd"
    fi
}


function bystarHereAcctContainerPlone3UserGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bpoIdHome=$( FN_absolutePathGet ~${bpoId} )

  # check to see if we should go live or here/local

  thisTargetMode=$( bystarTargetModeGet )

  # local is obsoleted by here
  if [ "${thisTargetMode}_" = "local_" ] ; then
      vis_hereContainerPlone3UserGet
      lpReturn
  fi

  if [ "${thisTargetMode}" = "here" ] ; then
      vis_hereContainerPlone3UserGet
      lpReturn
  fi

  if [ -f  ${bpoIdHome}/par.live/container/plone3User ] ; then
      # ~ma-57000/par.live/container/plone3User 
      containerPlone3User=$( cat ${bpoIdHome}/par.live/container/plone3User )

      if [ "${containerPlone3User}_" = "_" ] ; then
          EH_plone3ContainerZmiUserGet
      else
          echo ${containerPlone3User}
      fi
  else
      EH_plone3ContainerZmiUserGet
  fi

  lpReturn
}

function EH_plone3ContainerZmiUserGet {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    ANT_raw "This Should Never Happen. It means that the account setup was incomplete"
    ANT_raw "The File  ${bpoIdHome}/par.live/container/plone3User is missing"
    ANT_raw "You need to go back to the BACS for this acct and set it up with:" 
    ANT_raw "bystarAcctTarget.sh -h -v -n showRun -p bpoId=${bpoId} -i parLiveHere"

    exit 1
}



function bystarHereAcctContainerPlone3PasswdGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bpoIdHome=$( FN_absolutePathGet ~${bpoId} )

  # check to see if we should go live or here/local

  thisTargetMode=$( bystarTargetModeGet )

  # local is obsoleted by here
  if [ "${thisTargetMode}_" = "local_" ] ; then
      vis_hereContainerPlone3PasswdGet
      lpReturn
  fi
  if [ "${thisTargetMode}" = "here" ] ; then
      vis_hereContainerPlone3PasswdGet
      lpReturn
  fi

  if [ -f  ${bpoIdHome}/par.live/container/plone3Passwd ] ; then
      # ~ma-57000/par.live/container/plone3Passwd 
      containerPlone3Passwd=$( cat ${bpoIdHome}/par.live/container/plone3Passwd )
      if [ "${containerPlone3Passwd}_" = "_" ] ; then
          EH_plone3ContainerZmiPasswdGet
      else
          echo ${containerPlone3Passwd}
      fi
  else
      EH_plone3ContainerZmiPasswdGet
  fi
      
  lpReturn
}

function EH_plone3ContainerZmiPasswdGet {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    ANT_raw "This Should Never Happen. It means that the account setup was incomplete"
    ANT_raw "The File  ${bpoIdHome}/par.live/container/plone3Passwd is missing"
    ANT_raw "You need to go back to the BACS for this acct and set it up with:" 
    ANT_raw "bystarAcctTarget.sh -h -v -n showRun -p bpoId=${bpoId} -i parLiveHere"

    exit 1
}


function bystarHereAcctContainerPlone3BaseUrlGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bpoIdHome=$( FN_absolutePathGet ~${bpoId} )

  # check to see if we should go live or here/local

  thisTargetMode=$( bystarTargetModeGet )

  if [ "${thisTargetMode}_" = "local_" ] ; then
      echo "http://127.0.0.1:8080"
      lpReturn
  fi

  if [ "${thisTargetMode}" = "here" ] ; then
      echo "http://127.0.0.1:8080"
      lpReturn
  fi

  # ~sa-20000/par.live/container/ipAddr 
  if [ -f  ${bpoIdHome}/par.live/container/ipAddr ] ; then
      typeset ipAddr
      ipAddr=$( cat ${bpoIdHome}/par.live/container/ipAddr )
      if [ "${ipAddr}_" = "_" ] ; then
          EH_problem "Unset ipAddr"
          lpReturn 101
          plone3ContainerZmiPasswdGet
      else
          echo http://${ipAddr}:8080
      fi
  else
      echo "http://127.0.0.1:8080"
  fi
      
  lpReturn
}



function vis_rebuildModeSet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Typicals Usage: when reBuildInitialUpdateAll
     - vis_rebuildModeSet "building"
     - reBuildUpdateAll
     - vis_rebuildModeSet "built"

Then within non-idempotent functions,
     if [ "initialBuilding" != $( vis_rebuildModeGet ) ] ; then ; doNothing; fi;
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]
    EH_assert bpoIdHerePrep
    typeset rebuildMode="$1"

    EH_retOnFail

    typeset rebuildModeFile=${bpoIdHome}/par.live/rebuildMode.novc

    #if [ -f  ${rebuildModeFile} ] ; then 
        #opDoRet FN_fileSafeKeep ${rebuildModeFile}
    #fi
    

    case ${rebuildMode} in
        "unbuilt"|"built"|"initialBuilding")
            opDo eval "echo \"${rebuildMode}\" > ${rebuildModeFile}"
            ;;
        *)
            EH_problem "mode=${rebuildMode} -- Unknown -- invalid mode"
            lpReturn 101
            ;;
    esac

    lpReturn 
}



function vis_rebuildModeGet {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bpoId}_" != "INVALID_" ]]

  bpoIdHome=$( FN_absolutePathGet ~${bpoId} )

  if [ -f  ${bpoIdHome}/par.live/rebuildMode.novc ] ; then
      typeset thisTargetMode=$( cat ${bpoIdHome}/par.live/rebuildMode.novc )
      echo ${thisTargetMode}
  else
      echo "nil"
  fi
}    


function vis_rebuildModeReport {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Uses vis_rebuildModeShow to produce human reports of target mode.
_EOF_
    }
    typeset thisFunc=${G_thisFunc}
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdHerePrep

    if [[ "${bpoId}" == "all" ]] ; then
        typeset hereBystarUidList=$( bystarReports.sh -i thisContainerAccts )
        for bpoId in ${hereBystarUidList} ; do
            ${thisFunc}
        done
        lpReturn
    fi

    typeset thisTargetMode=$( vis_rebuildModeShow 2> /dev/null )

    ANT_raw "bpoId=${bpoId} rebuildMode=${thisTargetMode}"
    
    lpReturn 
}

