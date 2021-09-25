#!/bin/bash

IimBriefDescription="bsrGenewebManage.sh -- Create and maintain geneweb databases."

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bsrGenewebManage.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
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
*  /This File/ :: /opt/public/osmt/bin/bsrGenewebManage.sh 
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
*      ################ CONTENTS-LIST ################
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]* Status/Maintenance -- General TODO List
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/blee/bystarContinuum/genealogy/fullUsagePanel-en.org::Xref-Geneweb][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*
**      ====[[elisp:(org-cycle)][Fold]]====  This IIM enables creation of geneweb sites for SOs.
** TODO ====[[elisp:(org-cycle)][Fold]]==== Help/Tasks
    - Create Initial Database with passwd etc.

    - geneweb.first.1.last.byname.net
    - geneweb.1.last.byfamily.net
  
    - Create Link to it in plone  
**      ====[[elisp:(org-cycle)][Fold]]==== Design Notes
    - Based on bystarUid, create a new dataBase
             /var/lib/geneweb/sa-xxxx

    - Create a temp gedcom file in /tmp/
        vis_initialLoad
        
        The initial gedcom file is created by 
        hand entry into geneweb 
        Then the template is extracted with 
          gwb2ged -o sa-xxxx.ged sa-xxxx

    - Import the gedcom file into /var/lib/geneweb/sa-xxxx
      vis_initialLoad

          ged2gwb -o sa-xxxx /tmp/gedcomTmpInit

     - Setup Access Control Files

     - Setup DNS and apache Redirects   

_EOF_
}

function vis_describe { vis_moduleDescription; }

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lcnFileParams.libSh
. ${opBinBase}/lpParams.libSh

. ${opBinBase}/mmaWebLib.sh

# PRE parameters optional

typeset -t assignedUserIdNumber=""

# ./bystarHook.libSh
. ${opBinBase}/bystarHook.libSh
. ${opBinBase}/bystarInfoBase.libSh

# ./bystarLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
. ${opBinBase}/mmaQmailLib.sh
. ${opBinBase}/mmaDnsLib.sh

. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/lpCurrents.libSh

. ${opBinBase}/opSyslogLib.sh

# PRE parameters
typeset -t RABE="MANDATORY"
typeset -t bystarUid="MANDATORY"

function G_postParamHook {
     lpCurrentsGet
     bystarUidHome=$( FN_absolutePathGet ~${bystarUid} )
     return 0
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  #typeset acctsList=$( bystarBacsAcctsList )

  #oneBystarAcct=$( echo ${acctsList} | head -1 )
  oneBystarAcct=${currentBystarUid}
  
  oneSr="iso/sr/geneweb/default"

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Full Actions" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -i fullUpdate
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i fullDelete
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i serviceDelete
$( examplesSeperatorChapter "srBaseStart -- Initialize srBaseDir" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i srBaseStart
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i srBaseUpdate
$( examplesSeperatorChapter "dbaseInitialContent for Bystar Account" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i dbaseFullUpdate ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i dbaseCreate ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i dbaseInitialContentUpdate ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i dbaseInitialContentStdout ${oneBystarAcct}
$( examplesSeperatorChapter "dbase Password And Access Control Setup For Database" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i dbaseAccessControlVisible ${oneBystarAcct}
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -i dbaseAccessControlLimited ${oneBystarAcct}
$( examplesSeperatorChapter "ByStar Service Realization BaseDir Sync" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -p dbase=banan -i srGwbBaseDirInfo
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -p dbase=banan -i genewebToSrBase
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -p dbase=banan -i genewebFromSrBase
$( examplesSeperatorChapter "Bsr Images Process" )
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -p dbase=banan -i imagesList
${G_myName} ${extraInfo} -p bystarUid="${oneBystarAcct}" -p sr=${oneSr} -p dbase=banan -i imagesList | bueGimpManage.sh -h -v -n showRun -i scaleReplaceHeightTo 200
$( examplesSeperatorChapter "Access, Verification And Test" )
${G_myName} ${extraInfo} -i  visitUrl
_EOF_

  vis_examplesBxSvcLogInfo
}


noArgsHook() {
  vis_examples
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== srBaseStart
_CommentEnd_

function vis_srBaseStart {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Prepare Service Realization Bases such as log files base directories.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}
    #EH_assert bystarSrAnalyze

    if [ -z "${sr}" ] ; then
        EH_problem "Blank sr"
        lpReturn 101
    fi

    srBaseDir="${bystarUidHome}/${sr}"
    bsrAgent="${srBaseDir}/bsrAgent.sh"

    opDo FN_dirCreatePathIfNotThere ${srBaseDir}

    opDo FN_fileSafeCopy /libre/ByStar/InitialTemplates/iso/sr/common/bsrAgent.sh  ${bsrAgent}

    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/svcCapability ${G_myName}  # bsrGenewebManage.sh

    inBaseDirDo ${srBaseDir} bxtStartCommon.sh  -i startObjectGen auxLeaf

    srA2BaseDir="${srBaseDir}/a2VirDoms/main"
    bsrA2Agent=${srA2BaseDir}/bsrAgent.sh

    opDo FN_dirCreatePathIfNotThere ${srA2BaseDir}

    opDo FN_fileSafeCopy /libre/ByStar/InitialTemplates/iso/sr/common/bsrAgent.sh  ${bsrA2Agent}

    inBaseDirDo ${srA2BaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/svcCapability bsrA2GenewebManage.sh

    opDo FN_fileSafeCopy /libre/ByStar/InitialTemplates/iso/sr/common/bsrDnsAgent.sh  ${srA2BaseDir}/bsrDnsAgent.sh

    inBaseDirDo ${srA2BaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/domName genealogy

    #opDo chown -R lsipusr:employee ${srLogsBase}
    #opDo chmod -R  g+w ${srLogsBase}
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== srBaseUpdate
_CommentEnd_

function vis_srBaseUpdate {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Prepare Service Realization Bases such as log files base directories.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}
    EH_assert bystarSrAnalyze

    if [ -z ${srLogsBase} ] ; then
        EH_problem "Blank srLogsBase"
        lpReturn 101
    fi

    opDoExit mkdir -p ${srLogsBase}

    opDo chown -R lsipusr:employee ${srLogsBase}
    opDo chmod -R  g+w ${srLogsBase}
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Full Actions
_CommentEnd_



function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    bystarAcctAnalyze ${bystarUid}

    opDo vis_customizeAcctFromLine

    opDo vis_genewebBasePrep

    #opDo vis_configFileUpdate

    opDo vis_genewebVirDomUpdate

    #opDo vis_dnsUpdate
}


function vis_fullDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_serviceDelete

    opDoComplain vis_dnsDelete

    lpReturn
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== dbaseAccessControlVisible,  dbaseAccessControlLimited
_CommentEnd_

function vis_dbaseAccessControlVisible {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    opDoRet bystarHereAnalyzeAcctBagp

    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.gwf
    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.auth

    opDo eval "echo \"wizard_passwd=${bystarUidPasswdDecrypted}\" > /var/lib/geneweb/${dbaseName}.gwf"

    opDo chown -R geneweb /var/lib/geneweb/${dbaseName}.gwf
}


function vis_dbaseAccessControlLimited {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    opDoRet bystarHereAnalyzeAcctBagp

    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.gwf
    opDo FN_fileSafeKeep /var/lib/geneweb/${dbaseName}.auth

    opDo eval "echo \"wizard_passwd=${bystarUidPasswdDecrypted}\" > /var/lib/geneweb/${dbaseName}.gwf"
    opDo eval "echo \"auth_file=${dbaseName}.auth\" >> /var/lib/geneweb/${dbaseName}.gwf"
    opDo eval "echo \"family:4family\" > /var/lib/geneweb/${dbaseName}.auth"

    opDo chown -R geneweb /var/lib/geneweb/${dbaseName}.gwf
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== dbaseInitialContent for Bystar Account:
_CommentEnd_

function vis_dbaseFullUpdate {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    opDoRet bystarAcctAnalyze ${bystarUid}

  #opDo vis_dbaseCreate ${dbaseName}
  opDo vis_dbaseInitialContentUpdate ${dbaseName}
  opDo vis_dbaseAccessControlVisible ${dbaseName}

}


function vis_dbaseCreate {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    dbaseName=$1

    G_abortIfNotRunningAsRoot

    # First we create an empty dbase

    opDoExit cd /var/lib/geneweb
    opDo gwc -o ${dbaseName}
    opDo  chmod g+w /var/lib/geneweb/${dbaseName}.gwb
}


function vis_dbaseInitialContentUpdate {
  EH_assert [[ $# -eq 1 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  dbaseName=$1

  G_abortIfNotRunningAsRoot

  typeset tmpFile="$( FN_tempFile ).ged"

  opDo eval "vis_dbaseInitialContentStdout ${dbaseName} > ${tmpFile}"

  opDo ls -l ${tmpFile}

  opDoExit cd /var/lib/geneweb

  #opDo ged2gwb -f -o ${dbaseName} ${tmpFile}
  opDo ged2gwb -o ${dbaseName} ${tmpFile}
}

function vis_dbaseInitialContentStdout {
  EH_assert [[ $# -eq 1 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  dbaseName=$1

   opDoRet bystarHereAnalyzeAcctBagp

      cat  << _EOF_ 
0 HEAD
1 SOUR GeneWeb
2 VERS 5.01
2 NAME gwb2ged
2 CORP INRIA
3 ADDR Domaine de Voluceau
4 CONT B.P 105 - Rocquencourt
4 CITY Le Chesnay Cedex
4 POST 78153
4 CTRY France
3 PHON +33 01 39 63 55 11
2 DATA sa-20000.gwb
1 DATE 27 JUL 2010
2 TIME 02:52:37
1 FILE ${dbaseName}.ged
1 GEDC
2 VERS 5.5
2 FORM LINEAGE-LINKED
1 CHAR UTF-8
0 @I3@ INDI
1 NAME ${cp_FirstName} /${cp_LastName}/
1 SEX M
1 DEAT
0 @F1@ FAM
0 TRLR
_EOF_
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== genewebToSrBase, genewebFromSrBase, genewebInSrBaseInfo
_CommentEnd_

function srGwbBaseDir {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    EH_assert bystarSrAnalyze

    echo ${srBaseDir}/gwbBase
}

function vis_srGwbBaseDirInfo {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDoExit ls -ld $(srGwbBaseDir)
}

function vis_imagesList {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${dbase}" != "MANDATORY" ]]

    opDoExit find $(srGwbBaseDir)/images/${dbase} -type f -print  | grep -v '/old/'
}


function vis_genewebToSrBase {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    EH_assert bystarSrAnalyze
    EH_assert [[ "${dbase}" != "MANDATORY" ]]

    FN_dirCreatePathIfNotThere ${srBaseDir}/gwbBase

    opDoExit cd /var/lib/geneweb

    opDo /etc/init.d/geneweb stop

    opDo eval "find . -print | grep -v CVS | grep ${dbase} | cpio -o | (cd ${srBaseDir}/gwbBase; cpio -imdv)"

    opDo /etc/init.d/geneweb start

    opDo chown -R lsipusr:employee ${srBaseDir}/gwbBase
}

function vis_genewebFromSrBase {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bystarUidCentralPrep
    opDoRet bystarAcctAnalyze ${bystarUid}

    EH_assert bystarSrAnalyze
    EH_assert [[ "${dbase}" != "MANDATORY" ]]

    opDoExit cd ${srBaseDir}/gwbBase

    opDo /etc/init.d/geneweb stop

    opDo eval "find . -print | grep -v CVS | grep ${dbase} | cpio -o | (cd /var/lib/geneweb; cpio -imdv)"

    opDo chown -R geneweb /var/lib/geneweb

    opDo /etc/init.d/geneweb start
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Access, Verfications and Tests
_CommentEnd_

function vis_visitUrl {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    #EH_assert bystarUidCentralPrep
    #opDoRet bystarAcctAnalyze ${bystarUid}

    #EH_assert bystarSrAnalyze

    #opDo find_app.sh "firefox"
    #opDo bx-browse-url.sh -i openUrlNewTab http://${srFqdn}

    echo http://localhost:2317

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Log Files
_CommentEnd_


function bxSvcLogParamsObtain {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Expects $1 as ${bystarUidHome}
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    #EH_assert bystarSrAnalyze

    bxSvcLogDir="/var/log"
    bxSvcLogFile="/var/log/geneweb.log"
    bxSvcLogErrFile="/var/log/geneweb.log"

    lpReturn
}


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
