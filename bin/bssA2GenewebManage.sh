#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bsrA2GenewebManage.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
# *CopyLeft*
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/aais/bx/bin/bssA2GenewebManage.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
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
**      ====[[elisp:(org-cycle)][Fold]]====  This IIM enables creation of Apache2 (A2) geneweb sites for SOs.
** TODO ====[[elisp:(org-cycle)][Fold]]==== Help/Tasks
    - Create Link to it in plone  
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

. ${opBinBase}/bpo_lib.sh
. ${opBinBase}/bpoId_lib.sh

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/bystarLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lcnFileParams.libSh
. ${opBinBase}/lpParams.libSh

# . ${opBinBase}/mmaWebLib.sh

# PRE parameters optional

typeset -t assignedUserIdNumber=""

# ./bystarHook.libSh
. ${opBinBase}/bystarHook.libSh
# . ${opBinBase}/bystarInfoBase.libSh

# ./bystarLib.sh
. ${opBinBase}/bystarLib.sh
# . ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
# . ${opBinBase}/mmaQmailLib.sh
# . ${opBinBase}/mmaDnsLib.sh

# . ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh

. ${opBinBase}/bxioCommon_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/opSyslogLib.sh

. ${opBinBase}/usgBpos_lib.sh

# PRE parameters
typeset -t ss=""      # Services Specifications
typeset -t bpoId=""   # aaisBpo

function G_postParamHook {
    if [ ! -z "${bpoId}" ] ; then
        bpoIdPrep
        bpoHome=$( FN_absolutePathGet ~${bpoId} )
    fi

    bisosCurrentsGet
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  #typeset acctsList=$( bystarBacsAcctsList )

  #oneBystarAcct=$( echo ${acctsList} | head -1 )
  currentBystarUid=NOTYET
  oneBystarAcct=${currentBystarUid}

  oneSr="iso/sr/geneweb/default/a2VirDoms/main"

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Full Actions" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i fullUpdate
${G_myName} ${extraInfo} -p bpoId=aaisByDomain -p sr=${oneSr} -i fullUpdate
$( examplesSeperatorChapter "Virtual Host Geneweb Apache2 CONFIG  (geneweb.xxx)" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VirDomFileNameGet
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VirDomStdout
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VirDomUpdate
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VirDomVerify
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VirDomShow
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VirDomDelete
$( examplesSeperatorChapter "bsr Bases Prep (iso,var,control)" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i srA2VarBasePrep
$( examplesSeperatorChapter "Enable/Disable Module -- NOTYET" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i apache2ConfEnable        
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i apache2ConfDisable
$( examplesSeperatorChapter "Testing And Verifications" )
${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i visitUrl
_EOF_

  vis_examplesBxSvcLogInfo
}


noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Full Actions
_CommentEnd_

function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO ====[[elisp:(org-cycle)][Fold]]==== Incomplete and untested.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bpoIdPrep
}

function vis_fullUpdate%% {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO ====[[elisp:(org-cycle)][Fold]]==== Incomplete and untested.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bpoIdPrep

    opDo vis_genewebBasePrep

    #opDo vis_configFileUpdate
}


function vis_fullDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO ====[[elisp:(org-cycle)][Fold]]==== Incomplete and untested.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_serviceDelete

    lpReturn
}


function vis_serviceDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO ====[[elisp:(org-cycle)][Fold]]==== Incomplete and untested.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}" != "MANDATORY" ]]

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== srA2VirDom -- stdout, update, verify
_CommentEnd_


function vis_srA2VirDomStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    EH_assert bystarSrAnalyze

    dateTag=`date +%y%m%d%H%M%S`

    cat  << _EOF_
# VirtualHost for ${srFqdn} Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName ${srFqdn}
    ServerAdmin webmaster@${srFqdn}

    ErrorLog ${srA2LogBaseDir}/error_log
    CustomLog ${srA2LogBaseDir}/access_log common

    RewriteEngine On                                                      
    ProxyPass / http://0.0.0.0:2317/
    ProxyPassReverse / http://0.0.0.0:2317/

        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>

</VirtualHost>
_EOF_
}


function vis_srA2VirDomUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bpoIdPrep
  
    typeset thisConfigFile=$( vis_srA2VirDomFileNameGet )

    FN_fileSafeKeep ${thisConfigFile}

    vis_srA2VirDomStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    typeset siteConfigFile=$( FN_nonDirsPart ${thisConfigFile} )
    opDo a2ensite ${siteConfigFile}

    opDo service apache2 reload
}

function vis_srA2VirDomVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bpoIdPrep

    
    typeset thisConfigFile=$( vis_srA2VirDomFileNameGet )

    typeset tmpFile=$( FN_tempFile )

    vis_srA2VirDomStdout > ${tmpFile} 

    FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
    
    FN_fileRmIfThere ${tmpFile} 
}

function vis_srA2VirDomShow {
    EH_assert [[ $# -eq 0 ]]

    EH_assert bpoIdPrep
  
    typeset thisConfigFile=$( vis_srA2VirDomFileNameGet )

    opDo ls -l ${thisConfigFile} 
}

function vis_srA2VirDomDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO ====[[elisp:(org-cycle)][Fold]]==== Old -- Needs to be updated.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

  
    opDo /bin/rm "/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}" "/etc/apache2/sites-enabled/geneweb.${cp_acctMainBaseDomain}"

    #opDo /etc/init.d/apache2 force-reload
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== srA2 BasesPrep (logs, etc)
_CommentEnd_


function vis_srA2VarBasePrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bpoIdPrep

    EH_assert bystarSrAnalyze

    opDoExit mkdir -p ${srA2LogBaseDir}

    #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2/geneweb
    #opDo chown -R bystar:bisos ${opAcct_homeDir}/lcaApache2/geneweb
    #opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/geneweb
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== apache2ConfEnable / apache2ConfDisable
_CommentEnd_

function vis_apache2ConfEnable {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** TODO ====[[elisp:(org-cycle)][Fold]]==== Has not been completed and tested yet
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDo service apache2 restart
    opDo a2enconf geneweb
    opDo service apache2 reload
    ANT_raw "test it with: ${G_myName} ${extraInfo} -p bpoId=${oneBystarAcct} -p sr=${oneSr} -i visitUrl"
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

    EH_assert bpoIdPrep

    EH_assert bystarSrAnalyze

    #opDo find_app.sh "firefox"
    #opDo bx-browse-url.sh -i openUrlNewTab http://${srFqdn}

    echo http://${srFqdn}

    lpReturn
}


_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Log Files
_CommentEnd_


function bxSvcLogParamsObtain {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Expects $1 as ${bpoHome}
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    EH_assert bystarSrAnalyze

    bxSvcLogDir="${srA2LogBaseDir}"
    bxSvcLogFile="${bxSvcLogDir}/access_log"
    bxSvcLogErrFile="${bxSvcLogDir}/error_log"

    lpReturn
}



####+BEGIN: bx:dblock:bash:end-of-file :type "basic"
_CommentBegin_
*      ================ /[dblock] -- End-Of-File Controls/
_CommentEnd_
#+STARTUP: showall
#local variables:
#major-mode: sh-mode
#fill-column: 90
# end:
####+END:
