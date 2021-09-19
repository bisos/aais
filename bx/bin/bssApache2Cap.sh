#!/bin/bash

IimBriefDescription="bsrA2GenericManage.sh: A BSR svcCapabilty for Apache2 Web Sites based on specified flavor (generic, geneweb, gitweb, plone3)."

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bsrApache2Cap.sh,v 1.3 2016-08-10 02:04:16 lsipusr Exp $"
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/aais/bx/bin/bssApache2Cap.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
    exit $?
fi
####+END:


_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/ ::  [[elisp:(org-cycle)][| ]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[file:Panel.org][Panel]] | [[elisp:(blee:ppmm:org-mode-toggle)][Nat]] | [[elisp:(bx:org:run-me)][Run]] | [[elisp:(bx:org:run-me-eml)][RunEml]] | [[elisp:(delete-other-windows)][(1)]] | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] [[elisp:(org-cycle)][| ]]
** /Version Control/ ::  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_



_CommentBegin_
*      ================
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]] CONTENTS-LIST ################
*  [[elisp:(org-cycle)][| ]]  Notes         :: *[Current-Info:]* Status/Maintenance -- General TODO List [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*  [[elisp:(org-cycle)][| ]]  Xref          :: *[Related/Xrefs:]*  <<Xref->>  -- External Documents  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Xref         :: [[file:/libre/ByStar/InitialTemplates/activeDocs/bxRefModel/bxSrf/fullUsagePanel-en.org::Xref-][BxSRF and BISP Panel]]  [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Xref         :: /libre/ByStar/InitialTemplates/activeDocs/bxServices/bxsrModes/fullUsagePanel-en.org  [[elisp:(org-cycle)][| ]]
*  [[elisp:(org-cycle)][| ]]  Desc          :: *[Module Description:]* [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Desc         ::  This IIM enables creation of Apache2 (A2) sites for SOs based on specified flavor (generic, geneweb, gitweb, plone3). [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Desc         ::  Starting a site from within so/sr/apache2/svcName can also be through bxtStartBsr.sh [[elisp:(org-cycle)][| ]]
**  [[elisp:(org-cycle)][| ]]  Desc         ::  Help/Tasks [[elisp:(org-cycle)][| ]]
    - Create Link to it in plone  
_EOF_
}

function vis_describe { vis_moduleDescription; }

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Libs          :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

. ${opBinBase}/bxo_lib.sh
. ${opBinBase}/bxoId_lib.sh

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
#. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
# . ${opBinBase}/mmaQmailLib.sh
# . ${opBinBase}/mmaDnsLib.sh

#. ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh

. ${opBinBase}/bxioCommon_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/usgBpos_lib.sh

. ${opBinBase}/opSyslogLib.sh

# PRE parameters
# typeset -t ss="MANDATORY"
# typeset -t bxoId="MANDATORY"

typeset -t ss=""      # Services Specifications
typeset -t bxoId=""   # aabisBpo

function G_postParamHook {
    if [ ! -z "${bxoId}" ] ; then
        bxoIdPrep
        bxoHome=$( FN_absolutePathGet ~${bxoId} )
    fi

    bisosCurrentsGet
    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Examples      :: Examples [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_examples {
  typeset extraInfo="-h -v -n showRun -r basic"
  #typeset extraInfo=""
  #typeset acctsList=$( bystarBacsAcctsList )

  #oneBystarAcct=$( echo ${acctsList} | head -1 )
  # currentBystarUid=NOTYET
  oneBystarAcct=aaisByDomain

  #oneSs="iso/sr/geneweb/default/a2VirDoms/main"
  #oneSs="so/sr/apache2/web3"
  oneSs="so/sr/apache2/docBySource"

  visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Full Actions" )
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i startAndFullUpdate svcCapabilityFlavor svcName svcFqdn
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i startAndFullUpdate generic docBySource doc.bysource.org
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i fullUpdate
${G_myName} ${extraInfo} -p bxoId=aaisByDomain -p ss=${oneSs} -i fullUpdate
$( examplesSeperatorChapter "Initial Apache2 Content" )
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i initialContentStdout
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i initialContentStdout generic
$( examplesSeperatorChapter "Virtual Host Apache2 CONFIG" )
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomFileNameGet
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomStdout
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomStdout generic
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomUpdate
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomVerify
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomShow
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srA2VirDomDelete
$( examplesSeperatorChapter "bsr Bases Prep (iso,var,log,data,control)" )
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i srSvcBasesPrep
$( examplesSeperatorChapter "srBaseStart -- Initialize srBaseDir" )
${G_myName} ${extraInfo} -p bxoId="${oneBystarAcct}" -p ss=${oneSs} -i srBaseStart svcCapabilityFlavor svcName svcFqdn
${G_myName} ${extraInfo} -p bxoId="${oneBystarAcct}" -p ss=${oneSs} -i srBaseStart generic docBySource doc.bysource.org
${G_myName} ${extraInfo} -p bxoId="${oneBystarAcct}" -p ss=${oneSs} -i srBaseUpdate
$( examplesSeperatorChapter "Enable/Disable Module" )
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i apache2ConfEnable
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i apache2ConfDisable
$( examplesSeperatorChapter "Testing And Verifications" )
${G_myName} ${extraInfo} -p bxoId=${oneBystarAcct} -p ss=${oneSs} -i visitUrl
_EOF_

  vis_examplesBxSvcLogInfo ${oneSs}
}


noArgsHook() {
  vis_examples
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: vis_srBaseStart svcCapabilityFlavor svcName svcFqdn [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_srBaseStart {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
** Usually Invoked from /opt/public/osmt/bin/bxtStartBsr.sh to create srBase
** Expects -p bxoId=  and -p ss=
** Create needed files and directories in srBase.
** Prepare Service Realization Bases -- Logs, Data, Control directories are then built based on this svcCapability.
_EOF_
    }
    EH_assert [[ $# -ge 2 ]]

    typeset svcCapabilityFlavor=$1
    typeset svcName=$2

    typeset srDomName="notyet"
    typeset srFqdn="notyet.example.com"
    
    if [[ $# -eq 3 ]] ; then
        srFqdn=$3
        srDomName=${srFqdn%%.*}
    fi  

    typeset svcCapabilityName="apache2"

    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bxoIdPrep
    EH_assert [ -n "${ss}" ]

    srBaseDir="${bxoHome}/${ss}"
    bsrAgent="${srBaseDir}/bsrAgent.sh"

    opDo FN_dirCreatePathIfNotThere ${srBaseDir}

    opDo FN_fileSafeCopy /libre/ByStar/InitialTemplates/iso/sr/common/bsrAgent.sh  ${bsrAgent}
    opDo FN_fileSafeCopy /libre/ByStar/InitialTemplates/iso/sr/common/Panel.org  ${srBaseDir}/Panel.org    

    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/svcCapabilityName ${svcCapabilityName}
    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/svcCapabilityAgent ${G_myName}
    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/svcCapabilityFlavor ${svcCapabilityFlavor}    
    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/svcName ${svcName}        

    inBaseDirDo ${srBaseDir} bxtStartCommon.sh  -i startObjectGen auxLeaf

    # NOTYET -- Domains should be auto generated unless specified on command line
    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/srDomName ${srDomName}
    inBaseDirDo ${srBaseDir} fileParamManage.py -i fileParamWritePath ./srInfo/srFqdn ${srFqdn}
    
    opDo FN_fileSafeCopy /libre/ByStar/InitialTemplates/iso/sr/common/bsrDnsAgent.sh  ${srBaseDir}/bsrDnsAgent.sh

    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: vis_srBaseUpdate [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_srBaseUpdate {
   G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Prepare Service Realization Bases such as log files base directories.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bxoIdPrep
    EH_assert bxoSrAnalyze
    
    # NOTYET
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Full          :: Full Actions (startAndFullUpdate, fullUpdate, fullDelete) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_startAndFullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Full         :: vis_startFullUpdate: Incomplete and untested. [[elisp:(org-cycle)][| ]]
_EOF_
    }

    opDo vis_srBaseStart $@

    opDo vis_fullUpdate
}


function vis_fullUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Full         :: vis_fullUpdate: Incomplete and untested. [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bxoIdPrep

    opDo vis_srSvcBasesPrep

    opDo vis_srA2VirDomUpdate
}

function vis_fullUpdate%% {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Full         :: vis_fullUpdate: Incomplete and untested. [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bxoIdPrep

    opDo vis_srSvcBasesPrep

    opDo vis_srA2VirDomUpdate
}


function vis_fullDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Full         :: vis_fullDelete: Incomplete and untested. [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    opDo vis_serviceDelete

    lpReturn
}


function vis_serviceDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Full         :: vis_serviceDelete: Incomplete and untested. [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bxoId}" != "MANDATORY" ]]

    lpReturn
}



_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: initialContentStdout_ generic,plone3,geneweb,gitweb,gallery  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_initialContentStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  initialContent      ::  vis_initialContentStdout -- Dispatch   [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bxoIdPrep
    EH_assert [ -n "${ss}" ]

    EH_assert bxoSrAnalyze

    #opDo echo ${srDomName} ${srFqdn} ${svcName} ${svcCapabilityName} ${svcCapabilityAgent} ${svcCapabilityFlavor}
    #opDo echo ${srSvcBaseLogs} ${srSvcBaseData} ${srSvcBaseControl}  ${srSvcBaseTmp} ${srSvcBaseMailDir}

    dateTag=$( date +%y%m%d%H%M%S )

    if [ -z ${svcCapabilityFlavor} ] ; then
        EH_problem "Missing svcCapabilityFlavor"
        lpReturn 101
    fi

    opDo initialContentStdout_${svcCapabilityFlavor}
}


function initialContentStdout_generic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  initialContent      ::  initialContentStdout_generic   [[elisp:(org-cycle)][| ]]
_EOF_
    }

    cat  << _EOF_
# VirtualHost for ${srFqdn} -- ${svcName},${svcCapabilityName},${svcCapabilityAgent}  Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit
#opDo echo ${srDomName} ${srFqdn} ${svcName} ${svcCapabilityName} ${svcCapabilityAgent} ${svcCapabilityFlavor}
#opDo echo ${srSvcBaseLogs} ${srSvcBaseData} ${srSvcBaseControl}  ${srSvcBaseTmp} ${srSvcBaseMailDir}
_EOF_
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: srA2VirDomStdout_ generic,plone3,geneweb,gitweb,gallery  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_srA2VirDomStdout {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  srA2VirDomStdout      ::  vis_srA2VirDomStdout -- Dispatch   [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    EH_assert bxoSrAnalyze

    #opDo echo ${srDomName} ${srFqdn} ${svcName} ${svcCapabilityName} ${svcCapabilityAgent} ${svcCapabilityFlavor}
    #opDo echo ${srSvcBaseLogs} ${srSvcBaseData} ${srSvcBaseControl}  ${srSvcBaseTmp} ${srSvcBaseMailDir}

    dateTag=$( date +%y%m%d%H%M%S )

    if [ -z ${svcCapabilityFlavor} ] ; then
        EH_problem "Missing svcCapabilityFlavor"
        lpReturn 101
    fi

    opDo srA2VirDomStdout_${svcCapabilityFlavor}
}


function srA2VirDomStdout_generic {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  srA2VirDomStdout      ::  srA2VirDomStdout_generic   [[elisp:(org-cycle)][| ]]
_EOF_
    }

    cat  << _EOF_
# VirtualHost for ${srFqdn} -- ${svcName},${svcCapabilityName},${svcCapabilityAgent}  Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName ${srFqdn}
    ServerAdmin webmaster@${srFqdn}

    ErrorLog ${srSvcBaseLogs}/error_log
    CustomLog ${srSvcBaseLogs}/access_log common

    DocumentRoot ${srSvcBaseData}/html

    <Directory />
       Require all granted
    </Directory>

    <Directory ${srSvcBaseData}/html>
        Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch
        AllowOverride All
        order allow,deny
        Allow from all
    </Directory>

</VirtualHost>
_EOF_
}


_CommentBegin_
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
_CommentEnd_



_CommentBegin_
# VirtualHost for gitweb.${cp_acctMainBaseDomain} Generated ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName gitweb.${cp_acctMainBaseDomain}
    ServerAdmin webmaster@${cp_acctMainBaseDomain}

    <Directory />
       Require all granted
    </Directory>

    DocumentRoot ${opAcct_homeDir}/lcaApache2/gitweb/gitweb
    ErrorLog ${opAcct_homeDir}/lcaApache2/gitweb/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/gitweb/logs/access_log common

    <Directory ${opAcct_homeDir}/lcaApache2/gitweb/gitweb>
        Options +ExecCGI +FollowSymLinks +SymLinksIfOwnerMatch
        AllowOverride All
        order allow,deny
        Allow from all
        AddHandler cgi-script cgi
        DirectoryIndex gitweb.cgi
    </Directory>

</VirtualHost>
_CommentEnd_

_CommentBegin_
# VirtualHost for web.by-star.com Generated by bystarApache2Admin.sh on 130217190053

<VirtualHost 198.62.92.171>
    ServerName web.by-star.com
    ServerAdmin webmaster@by-star.com
    DocumentRoot /acct/smb/com/by-star/lcaApache2/web/htdocs
    #ScriptAlias /cgi-bin/ "/acct/smb/com/by-star/lcaApache2/web/cgi-bin/"      
    ErrorLog /acct/smb/com/by-star/lcaApache2/web/logs/error_log
    CustomLog /acct/smb/com/by-star/lcaApache2/web/logs/access_log common

    Alias /gallery /acct/smb/com/by-star/lcaApache2/web/htdocs/gallery

    <Directory /acct/smb/com/by-star/lcaApache2/web/htdocs/gallery>
      Options FollowSymLinks
      AllowOverride Limit Options FileInfo
    </Directory>
</VirtualHost>
_CommentEnd_
    





_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: srA2VirDom -- update, verify, show, delete [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_srA2VirDomUpdate {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    # if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bxoIdPrep

    typeset thisConfigFile=$( vis_srA2VirDomFileNameGet )

    lpDo FN_fileSafeKeep ${thisConfigFile}

    lpDo eval vis_srA2VirDomStdout \| sudo tee ${thisConfigFile} \> /dev/null

    opDo ls -l ${thisConfigFile}

    typeset siteConfigFile=$( FN_nonDirsPart ${thisConfigFile} )
    opDo sudo a2ensite ${siteConfigFile}

    opDo sudo service apache2 reload
}

function vis_srA2VirDomVerify {
    EH_assert [[ $# -eq 0 ]]
    EH_assert bxoIdPrep

    
    typeset thisConfigFile=$( vis_srA2VirDomFileNameGet )

    typeset tmpFile=$( FN_tempFile )

    vis_srA2VirDomStdout > ${tmpFile} 

    FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
    
    FN_fileRmIfThere ${tmpFile} 
}

function vis_srA2VirDomShow {
    EH_assert [[ $# -eq 0 ]]

    EH_assert bxoIdPrep
  
    typeset thisConfigFile=$( vis_srA2VirDomFileNameGet )

    opDo ls -l ${thisConfigFile} 
}

function vis_srA2VirDomDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Subject      :: Old -- Needs to be updated. [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bxoId}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

  
    opDo /bin/rm "/etc/apache2/sites-available/geneweb.${cp_acctMainBaseDomain}" "/etc/apache2/sites-enabled/geneweb.${cp_acctMainBaseDomain}"

    #opDo /etc/init.d/apache2 force-reload
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: vis_srSvcBasesPrep  (logs, data) [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_srSvcBasesPrep {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    # if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bxoIdPrep
    EH_assert [ -n "${ss}" ]

    EH_assert bxoSrAnalyze

    # lpDo echo ${srSvcBaseLogs} ${srSvcBaseData} ${srSvcBaseControl}  ${srSvcBaseTmp} ${srSvcBaseMailDir}

    if [ ! -d ${srSvcBaseLogs} ] ; then
        opDoExit mkdir -p ${srSvcBaseLogs}
    else
        ANV_cooked "${srSvcBaseLogs} exists -- mkdir skipped"
    fi
    
    if [ ! -d ${srSvcBaseData} ] ; then
        opDoExit mkdir -p ${srSvcBaseData}/html
    else
        ANV_cooked "${srSvcBaseData} exists -- mkdir skipped"
    fi

    if [ "${svcCapabilityFlavor}" == "generic" ] ; then
        opDo eval "vis_initialContentStdout > ${srSvcBaseData}/html/index.html"
    fi

    #opDo chown -R ${bxoId} ${opAcct_homeDir}/lcaApache2/geneweb
    #opDo chown -R lsipusr:employee ${opAcct_homeDir}/lcaApache2/geneweb
    #opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2/geneweb
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: apache2ConfEnable / apache2ConfDisable [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_apache2ConfEnable {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
**  [[elisp:(org-cycle)][| ]]  Subject      :: Has not been completed and tested yet [[elisp:(org-cycle)][| ]]
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    # if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    opDo sudo service apache2 restart
    #opDo a2enconf geneweb
    opDo sudo service apache2 reload
    ANT_raw "test it with:  -i visitUrl"
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: vis_visitUrl: Access, Verfications and Tests [[elisp:(org-cycle)][| ]]
_CommentEnd_

function vis_visitUrl {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]

    EH_assert bxoIdPrep

    EH_assert bxoSrAnalyze

    #opDo find_app.sh "firefox"
    #opDo bx-browse-url.sh -i openUrlNewTab http://${srFqdn}

    echo http://${srFqdn}

    lpReturn
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Code          :: bxSvcLogParamsObtain for ./opSyslogLib.sh -- Log Files [[elisp:(org-cycle)][| ]]
_CommentEnd_


function bxSvcLogParamsObtain {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Invoked from ./opSyslogLib.sh
_EOF_
    }
    EH_assert [[ $# -eq 1 ]]

    EH_assert bxoSrAnalyze

    bxSvcLogDir="${srSvcBaseLogs}"
    bxSvcLogFile="${bxSvcLogDir}/access_log"
    bxSvcLogErrFile="${bxSvcLogDir}/error_log"

    lpReturn
}



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
