#!/bin/bash


####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] |
"
FILE="
*  /This File/ :: /bisos/bsip/bin/bystarBarcProc.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
    exit $?
fi
####+END:


vis_help () {
 cat  << _EOF_

  TODO:
  =====

- Add reason as a parameter. Capture in BARC.

- Add acctUid=xxx For PreBuilt sites

- Add Features="Continuum,Student"

Bystar Account Creation Starts Here -- ByStar Factory Script.

Creates a BARC (Bystar Account Request Container) based on command line 
and processes it to various degrees.

On Command Line, 
   ${G_myName}
   ${G_myName} byname
   ${G_myName} bysmb
for examples.

With Bbdb,
    x bystar-
See bbdb-bystarFactory.el

From the web



_EOF_
}


. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bystarLib.sh
. ${aaisBinBase}/bystarBarc.libSh
. ${opBinBase}/opDoAtAsLib.sh

. ${opBinBase}/bystarHook.libSh
. ${aaisBinBase}/bystarNspLib.sh

# ./bystarPlatform.libSh
# . ${opBinBase}/bystarPlatform.libSh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh


# /bisos/core/bsip/bin/bisosCurrents_lib.sh
. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/lpInBaseDirDo.libSh
. ${opBinBase}/lpReRunAs.libSh

typeset -t ServiceType=""
typeset -t ServiceSupportType=""

# PRE parameters for SMB
typeset -t CompanyName=""
typeset -t BusinessType=""
typeset -t Domain1="MANDATORY"
typeset -t Domain2="MANDATORY"
typeset -t streetAddress=""
typeset -t cityAddress=""
typeset -t stateAddress=""
typeset -t zipcodeAddress=""
typeset -t phone=""
typeset -t fax=""

# PRE parameters for bymemory
typeset -t FirstName=MANDATORY
typeset -t LastName=MANDATORY
typeset -t datebirth=""
typeset -t datedeath=""

# PRE parameters for byalias
typeset -t FirstName=""
typeset -t LastName=""
typeset -t AliasName=""

# PRE parameters common
typeset -t contactPerson=""
typeset -t emailAdmin=""
typeset -t domainHost=""
typeset -t hostName=""

# default bystarUid Must Be "" not MANDATORY
typeset -t bystarUid=""
typeset -t originationMethod=""


# PRE parameters optional 

typeset -t none=""



noArgsHook() {
    if [[ $# -eq 0 ]] ; then
        vis_examples
        return
    fi

    case "$1" in
        bysmb)
            shift
            vis_examplesBysmb $@   
            ;;
        bca)
            shift
            vis_examplesBca $@   
            ;;
        byname)
            shift
            vis_examplesByname $@   
            ;;
        byalias)
            shift
            vis_examplesByalias $@   
            ;;
        bymemory)
            shift
            vis_examplesBymemory $@   
            ;;
        bywhere)
            shift
            vis_examplesBywhere $@   
            ;;
        all)
            shift
            vis_examplesBysmb $@   
            vis_examplesBca $@   
            vis_examplesByname $@   
            vis_examplesByalias $@   
            vis_examplesBymemory $@   
            vis_examplesBywhere $@   
            ;;
        *)
            echo "Usage: $0 {byname|byalias|bymemory|bysmb|bywhere|all}"
            exit 1
            ;;
    esac
}


function vis_examples {
    extraInfo="-h -v -n showRun"

  typeset visLibExamples=`visLibExamplesOutput ${G_myName}`

vis_examplesBysmb

 cat  << _EOF_
#### BYNAME ####
${G_myName} byname
#### BYMEMORY ####
${G_myName} bymemory
#### BYALIAS ####
${G_myName} byalias
#### BYSMB ####
${G_myName} bysmb
#### BCA -- Controlled/Slave Account ####
${G_myName} bca

_EOF_
}

function vis_examplesCommon {
    extraInfo="-h -v -n showRun"

 cat  << _EOF_
EXAMPLES:
#### $1 ####
${G_myName} ${extraInfo} ${bystarParamsMini} -i BarcStdout
${G_myName} ${extraInfo} ${bystarParamsMini} -i BarcFileCreate
${G_myName} ${extraInfo} ${bystarParamsMini} -i startToRegister
${G_myName} ${extraInfo} ${bystarParamsMini} -i startToFullFg
${G_myName} ${extraInfo} ${bystarParamsMini} -i startToEssentials
${G_myName} -v -n showRun ${bystarParamsMini} -i startToEssentials
${G_myName} ${extraInfo} ${bystarParamsMini} -i startToFullBg
${G_myName} ${extraInfo} ${bystarParamsMini} -i startToFullDev
--- RENEW/RELOCATE Existing Account ---
${G_myName} ${extraInfo} -p bystarUid=ua-35011 ${bystarParamsMini} -i renewPassive
${G_myName} ${extraInfo} -p bystarUid=ua-35011 ${bystarParamsMini} -i startToFullFg
--- Full ---
${G_myName} ${extraInfo} ${bystarParamsFull} -i BarcStdout
${G_myName} ${extraInfo} ${bystarParamsFull} -i BarcFileCreate
${G_myName} ${extraInfo} ${bystarParamsFull} -i startToRegister
${G_myName} ${extraInfo} ${bystarParamsFull} -i startToFullFg
${G_myName} ${extraInfo} ${bystarParamsFull} -i startToFullBg
${G_myName} ${extraInfo} ${bystarParamsFull} -i startToFullDev
_EOF_
}


function vis_examplesBysmb {
    extraInfo="-h -v -n showRun"

    #bystarParamsMini="-p serviceType=\"BYSMB\" -p supportType=\"TRIAL\" -p Domain2=\"mydomain\" -p Domain1=\"com\" "
    bystarParamsMini="-p serviceType=\"BYSMB\" -p supportType=\"COMMITTED\" -p Domain2=\"mydomain\" -p Domain1=\"com\" "
    bystarParamsFull="-p companyName=\"Some Name\" -p businessType=\"RetailStore\" -p domainName=\"mydomain\" -p domainNameExt=\"com\" -p contactPerson= -p emailAdmin= -p streetAddress= -p cityAddress= -p stateAddress= -p zipcodeAddress= -p phone= -p fax= -p domainHost=\"bysmb.net\""

    vis_examplesCommon "BYSMB"
}

function vis_examplesBca {
    extraInfo="-h -v -n showRun"

    bystarParamsMini="-p serviceType=\"BCA\" -p masterAcct=\"ea-59050\" -p FirstName=\"jim\" -p LastName=\"jones\" -p BcaTag=\"jim.jones\" "
    bystarParamsFull="${bystarParamsMini}"

    vis_examplesCommon "BCA"
}


function vis_examplesByname {
    extraInfo="-h -v -n showRun"

  #bystarParamsMini="-p serviceType=\"BYNAME\" -p supportType=\"TRIAL\" -p FirstName=\"jim\" -p LastName=\"jones\" "
  bystarParamsMini="-p serviceType=\"BYNAME\" -p supportType=\"COMMITTED\" -p FirstName=\"jim\" -p LastName=\"jones\" "
  bystarParamsFull="-p serviceType=\"BYNAME\" -p supportType=\"TRIAL\" -p FirstName=\"\" -p LastName=\"\" -p contactPerson= -p emailAdmin= -p domainHost=\"byname.net\""

    vis_examplesCommon "BYNAME"
}

function vis_examplesByalias {
    extraInfo="-h -v -n showRun"

  bystarParamsMini="-p serviceType=\"BYALIAS\" -p AliasName=\"soccerDad\" -p supportType=\"TRIAL\""
  bystarParamsFull="-p serviceType=\"BYALIAS\" -p FirstName=\"soccerDad\" -p contactPerson= -p emailAdmin= -p domainHost=\"byname.net\""

    vis_examplesCommon "BYALIAS"
}

function vis_examplesBymemory {
    extraInfo="-h -v -n showRun"

  bystarParamsMini="-p serviceType=\"BYMEMORY\" -p FirstName=\"jim\" -p LastName=\"jones\" -p supportType=\"TRIAL\""
  bystarParamsFull="-p serviceType=\"BYMEMORY\" -p FirstName=\"\" -p LastName=\"\" -p contactPerson= -p emailAdmin= -p domainHost=\"byname.net\""

    vis_examplesCommon "BYMEMORY"
}

function vis_examplesBywhere {
    extraInfo="-h -v -n showRun"

  bystarParamsMini="-p serviceType=\"BYWHERE\" -p WhereCode=\"1-98008-5742-19\" -p supportType=\"TRIAL\""
  bystarParamsFull="-p serviceType=\"BYWHERE\" -p WhereCode=\"1-98008-5742-19\" -p contactPerson= -p emailAdmin= -p domainHost=\"byname.net\""

    vis_examplesCommon "BYWHERE"
}


function vis_BarcStdout {
   EH_assert [[ $# -eq 0 ]]

  ANT_raw "creating a BARC Container"

  if [ "${serviceType}_" == "BCA_" ] ; then
    cp_MasterAcct=${masterAcct}
    masterAcctBagpLoad
    supportType="${cp_master_ServiceSupportType}"
  fi

   bystarServiceSupportHookParamsSet ${serviceType} ${supportType}
 
   if [ "${originationMethod}_" == "_" ] ; then
       originationMethod="cmdLine"
   fi

 
 cat  << _EOF_
function BarcContainer {
    function BarcContainerCommon {
      bc_serviceType="${serviceType}"
      bc_serviceSupportType="${supportType}"

      bc_originationDate="${dateTag}"
      bc_originationMethod="${originationMethod}"
      bc_originatorHost="${opRunHostName}"
      bc_originatorId="${opRunAcctName}"

      bc_bystarUid="${bystarUid}"
    }
_EOF_


  bystarServiceSupportHookRun barcContainerStdoutSpecific "active"


  cat  << _EOF_
  BarcContainerCommon
  BarcContainer_${bystarServiceType}_${bystarServiceSupportType}
}
_EOF_
}


barcContainerStdoutSpecific_BYNAME_DEFAULT () {
   EH_assert [[ $# -eq 1 ]]

    if [ "$1_" = "passive_" ] ; then
        BarcTag="${bystarServiceType}_${bystarServiceSupportType}_${LastName}_${FirstName}"
        return
    fi


  cat  << _EOF_
    function BarcContainer_${bystarServiceType}_${bystarServiceSupportType} {
      bc_firstName="${FirstName}"
      bc_lastName="${LastName}"
    }
_EOF_

}

barcContainerStdoutSpecific_BYMEMORY_DEFAULT () {
   EH_assert [[ $# -eq 1 ]]

    if [ "$1_" = "passive_" ] ; then
        BarcTag="${bystarServiceType}_${bystarServiceSupportType}_${LastName}_${FirstName}"
        return
    fi

  cat  << _EOF_
    function BarcContainer_${bystarServiceType}_${bystarServiceSupportType} {
      bc_firstName="${FirstName}"
      bc_lastName="${LastName}"
    }
_EOF_

}


barcContainerStdoutSpecific_BYALIAS_DEFAULT () {
   EH_assert [[ $# -eq 1 ]]

    if [ "$1_" = "passive_" ] ; then
        BarcTag="${bystarServiceType}_${bystarServiceSupportType}_${AliasName}"
        return
    fi

  cat  << _EOF_
    function BarcContainer_${bystarServiceType}_${bystarServiceSupportType} {
      bc_AliasName="${AliasName}"
    }
_EOF_


}


barcContainerStdoutSpecific_BYSMB_DEFAULT () {
   EH_assert [[ $# -eq 1 ]]

    if [ "$1_" = "passive_" ] ; then
        BarcTag="${bystarServiceType}_${bystarServiceSupportType}_${Domain1}_${Domain2}"
        return
    fi

  cat  << _EOF_
    function BarcContainer_${bystarServiceType}_${bystarServiceSupportType} {
      bc_companyName=""
      bc_Domain1="${Domain1}"
      bc_Domain2="${Domain2}"
    }
_EOF_
}

barcContainerStdoutSpecific_BCA_DEFAULT () {
   EH_assert [[ $# -eq 1 ]]

    if [ "$1_" = "passive_" ] ; then
        BarcTag="${bystarServiceType}_${bystarServiceSupportType}_${masterAcct}_${LastName}_${FirstName}"
        return
    fi

  cat  << _EOF_
    function BarcContainer_${bystarServiceType}_${bystarServiceSupportType} {
      bc_masterAcct="${masterAcct}"
      bc_firstName="${FirstName}"
      bc_lastName="${LastName}"
      bc_BcaTag="${BcaTag}"
    }
_EOF_
}

barcContainerStdoutSpecific_DEFAULT_DEFAULT () {
   ANT_raw "Missing ${bystarServiceType}_${bystarServiceSupportType}"
}


function vis_BarcFileCreate {
   EH_assert [[ $# -eq 0 ]]

  if [ "${serviceType}_" == "BCA_" ] ; then
    cp_MasterAcct=${masterAcct}
    masterAcctBagpLoad
    supportType="${cp_master_ServiceSupportType}"
  fi

    bystarServiceSupportHookParamsSet ${serviceType} ${supportType}

    bystarServiceSupportHookRun barcContainerStdoutSpecific "passive"


    if isDisposableRegisterUid ; then
        BarcInfoBasePath="/libre/etc/bystar/infoBase/barc"
    else
        BarcInfoBasePath="/libre/ByStar/InfoBase/BARC"
    fi

    opDo mkdir -p ${BarcInfoBasePath}

    BarcBaseDir="${BarcInfoBasePath}/${bystarServiceType}/${bystarServiceSupportType}"

    opDo mkdir -p ${BarcBaseDir}

    BarcFileName=${BarcTag}.${dateTag}.BARC
    
    echo BarcFileName=${BarcBaseDir}/${BarcFileName} > ${BarcBaseDir}/${BarcFileName} 

    vis_BarcStdout 1>> ${BarcBaseDir}/${BarcFileName} 

    opDo ls -l ${BarcBaseDir}/${BarcFileName} 1>&2 

    echo ${BarcBaseDir}/${BarcFileName}
}

function vis_startToRegister {
    BarcFile=$( vis_BarcFileCreate 2> /dev/null )

    opDo bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i BarcRegister
}

function vis_startToEssentials {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    BarcFile=$( vis_BarcFileCreate 2> /dev/null )

    #bystarUid=$( bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i startToEssentials )
    #echo ${bystarUid}

    opDo bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i startToEssentials
}


function vis_startToFullFg {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    ANT_raw "Gen BarcFile"
    pauseForVerification

    #BarcFile=$( vis_BarcFileCreate 2> /dev/null )
    BarcFile=$( vis_BarcFileCreate )
    ANT_raw "About to Run bystarBarcProc.sh"
    pauseForVerification
    opDo bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i fullCreateFg
}

function vis_startToFullBg {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;
    BarcFile=$( vis_BarcFileCreate 2> /dev/null )

    opDo bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i fullCreateBg
}

function vis_startToFullDev {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;
    # Notyet
    # PauseForVerifications
    # Lots of debug
    #
    BarcFile=$( vis_BarcFileCreate 2> /dev/null )

    opDo bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i fullCreateFg
}

function vis_renewPassive {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    # Notyet
    # PauseForVerifications
    # Lots of debug
    #
    BarcFile=$( vis_BarcFileCreate 2> /dev/null )

    opDo bystarBarcProc.sh ${G_commandOptions} -p BarcFile="${BarcFile}" -i fullCreateFg
}

