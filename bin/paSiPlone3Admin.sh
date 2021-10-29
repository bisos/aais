#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:dblock:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"
typeset RcsId="$Id: bystarPlone3Admin.sh,v 1.1.1.1 2016-06-08 23:49:51 lsipusr Exp $"
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
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/pals/bin/bystarPlone3Admin.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
    exit $?
fi
####+END:

_CommentBegin_
####+BEGIN: bx:dblock:global:file-insert-cond :cond "./blee.el" :file "/libre/ByStar/InitialTemplates/software/plusOrg/dblock/inserts/topControls.org"
*      ================
*  /Controls/:  [[elisp:(org-cycle)][Fold]]  [[elisp:(show-all)][Show-All]]  [[elisp:(org-shifttab)][Overview]]  [[elisp:(progn (org-shifttab) (org-content))][Content]] | [[elisp:(bx:org:run-me)][RunMe]] | [[elisp:(delete-other-windows)][(1)]]  | [[elisp:(progn (save-buffer) (kill-buffer))][S&Q]]  [[elisp:(save-buffer)][Save]]  [[elisp:(kill-buffer)][Quit]] 
** /Version Control/:  [[elisp:(call-interactively (quote cvs-update))][cvs-update]]  [[elisp:(vc-update)][vc-update]] | [[elisp:(bx:org:agenda:this-file-otherWin)][Agenda-List]]  [[elisp:(bx:org:todo:this-file-otherWin)][ToDo-List]] 

####+END:
_CommentEnd_

_CommentBegin_
*      ================
*      ################ CONTENTS-LIST ################
*      ======[[elisp:(org-cycle)][Fold]]====== *[Current-Info:]*  Status, Notes (Tasks/Todo Lists, etc.)
_CommentEnd_

function vis_moduleDescription {  cat  << _EOF_
*      ======[[elisp:(org-cycle)][Fold]]====== *[Related/Xrefs:]*  <<Xref-Here->>  -- External Documents 
**      ====[[elisp:(org-cycle)][Fold]]==== [[file:/libre/ByStar/InitialTemplates/activeDocs/bxServices/versionControl/fullUsagePanel-en.org::Xref-VersionControl][Panel Roadmap Documentation]]
*      ======[[elisp:(org-cycle)][Fold]]====== *[Module Description:]*

lcaPlone3UrlApi.sh user passwd url zmiVerb zmiArgs

lcaPlone3Commands.sh user passwd baseAddr ploneVerb ploneArgs
                    -- Previously lcaPloneCommands.sh 

lcaPlone3Support.sh  -- iframe, redirect, ...

bystarPlone3Commands.sh -p bpoId=bystarUid  -i ploneAction ploneParams

bystarPlone3Feature.sh -p bpoId=bystarUid   FillUp the TOP/Below

bystarPlone3Styles.sh sits on top of bystarPlone3Features.sh does cssUpdate ... similar to plone3Proc.sh

----

bystarPlone3Initial.sh -p bpoId=bystarUid  Use initial templates to build the whole site

bystarPlone3Admin.sh -- Full Add, Backup, 

OLD
===
0) Set zope manager password with adduser in lcaPloneAdmin.sh

1) manager login on the left side ploneSite add  libreCenter.net
2) Create a PLONE (not Zope) user
3) /ploneId/prefs_users_overview  -- send email
4) See Pinneke's email for no email -- aclUsers ..

NEW
===
0) Set zope manager password with adduser in lcaPloneAdmin.sh

1) manager login on the left side ploneSite add  libreCenter.net
    bystarPlone3Commands -i ploneSiteAdd

1.1) Setup no emailConfirmation, mailhost, ...
    bystarPlone3Commands -i ploneSitePrep

2) Create a PLONE (not Zope) user
    bystarPlone3Commands -i ploneUserAdd

4) Set Role (Manager)
    bystarPlone3Commands -i ploneUserRoleSet manager

_EOF_
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Prefaces (Imports/Libraries)
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh

# . ${opBinBase}/bystarCentralAcct.libSh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

. ${opBinBase}/bystarHook.libSh

# bystarLib.sh
. ${opBinBase}/bystarLib.sh
#. ${opBinBase}/bynameLib.sh
. ${opBinBase}/mmaLib.sh
#. ${opBinBase}/mmaQmailLib.sh
#. ${opBinBase}/mmaDnsLib.sh

. ${opBinBase}/opAcctLib.sh
#. ${opBinBase}/lcaPloneLib.sh

#. ${opBinBase}/lpCurrents.libSh
. ${opBinBase}/lpParams.libSh


# bystarDnsDomain.libSh  
#. ${opBinBase}/bystarDnsDomain.libSh

# . ${opBinBase}/bystarInfoBase.libSh


# PRE parameters
typeset -t acctTypePrefix=""
typeset -t bpoId="MANDATORY"

function G_postParamHook {
    #bpoHome=$( FN_absolutePathGet ~${bystarUid} )
    lpCurrentsGet
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Examples
_CommentEnd_


function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo="
    typeset runInfo="-p ri=lsipusr:passive"

    typeset examplesInfo="${extraInfo} ${runInfo}"

    #oneBystarUid=${currentBystarUid}
    oneBystarUid=current
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  # NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset thisAcctTypePrefix="sa"
  #typeset thisOneSaNu="sa-20051"
  #typeset thisOneSaNu=${oneBystarAcct}
  #typeset thisOneSaNu=${currentBystarUid}
  typeset thisOneSaNu=${oneBystarUid}
  typeset oneSubject="qmailAddr_test"


    visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Full Top Levels" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i fullUpdate
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i fullEssentials
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i fullSupplements  # fullContents + fullBuild
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i fullContents  # create ~buid/lcaPlone3 if needed
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i fullBuild     # subject to platformBasaBuildMode
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i fullReCreate  # Can Be Done remotely with REST-API
$( examplesSeperatorChapter "PROVISIONING ACTIONS" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  fullAdd       # NOT Implemented
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -f -i  fullAdd    # NOT Implemented
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  ploneSiteAdd
$( examplesSeperatorChapter "Virtual Host (TLD) Plone CONFIG  (www.xxx)" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostPloneConfigStdout
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostPloneConfigUpdate
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostPloneConfigVerify
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostPloneConfigShow
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostPloneConfigDelete
$( examplesSeperatorChapter "Virtual Host (TLD) Plone CONFIG  (xxx.bysmb.net)" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostSldPloneConfigStdout
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostSldPloneConfigUpdate
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostSldPloneConfigVerify
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostSldPloneConfigShow
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  virHostSldPloneConfigDelete
$( examplesSeperatorChapter "DNS" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i dnsUpdate
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  dnsDelete
$( examplesSeperatorChapter "BACKUP" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  backupPloneSite
$( examplesSeperatorChapter "DEACTIVATION ACTIONS" )
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  fullDelete
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -i  serviceDelete
_EOF_
}

noArgsHook() {
  vis_examples
}

_CommentBegin_
*      ======[[elisp:(org-cycle)][Fold]]====== Module Functions
_CommentEnd_



noSubjectHook() {
  return 0
}

function vis_fullUpdate {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    vis_dnsUpdate

    vis_fullEssentials

    vis_fullSupplements
}

function vis_fullEssentials {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    opDoComplain vis_ploneSiteCreate

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneSitePrep

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneManagerAdd
}


function vis_fullReCreate {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneSiteAdd

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneSitePrep

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneManagerAdd
}



function vis_fullSupplements {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    opDo vis_fullContents

    opDo vis_fullBuild
}



function vis_fullContentsOld {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    #
    # If the site has already been configured, we run the site's own 
    # script otherwise we assume it is a fresh site and we initialize it.
    #
    if [[ -d ${bpoHome}/lcaPlone/ContentTree ]] ; then
        opDoAfterPause bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i lcaPloneBaseSetup

        opDoRet cd ${cp_acctUidHome}/lcaPlone
        EH_retOnFail

        opDo ./plone3Proc.sh  -i fullUpdateAll
    else
        opDoAfterPause bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i lcaPloneFullSetup
    fi
}

function vis_fullContents {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}" != "MANDATORY" ]]

    bystarBagpLoad

    opDoAfterPause bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i lcaPloneBaseSetup

    lpReturn
}

function vis_fullBuild {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Based on /libre/etc/bystar/usage/platformBasaBuildMode build the plone site to the extent specified.
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    opDo fileParamsLoadVarsFromBaseDir /libre/etc/bystar/usage

    #
    # Send the AcctIsReady Email
    #
    case ${cp_platformBasaBuildMode} in
        "")
            describeF
            ANT_cooked "platformBasaBuildMode is empty/blank -- fast for bpoId=${bystarUid} -- fullBuild Skipped:"
            ANT_cooked "Later Run: bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i ploneFullSetup"
            ;;

        "fast")
            describeF
            ANT_raw "fast for bpoId=${bystarUid} -- fullBuild Skipped:"
            ;;

        "complete")  
            if [[ -d ${bpoHome}/lcaPlone3 ]] ; then
                #opDoAfterPause bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i reBuildUpdateAll
                opDoAfterPause bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i ploneFullSetup
            else
                ANT_raw "No ${bpoHome}/lcaPlone3 -- fullBuild Skipped"
            fi
            ;;
        
        "mini")
            describeF
            ANT_raw "mini for bpoId=${bystarUid} is -- fullBuild Skipped"
            ;;

        *)
            EH_problem "cp_platformBasaBuildMode=${cp_platformBasaBuildMode} UnExpected -- No Action Taken"
            ;;
    esac

}


function vis_fullBuildObsoleted {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    #
    # If the site has already been configured, we run the site's own 
    # script otherwise we assume it is a fress site and we initialize it.
    #
    if [[ -d ${bpoHome}/lcaPlone/ContentTree ]] ; then
        opDoRet cd ${cp_acctUidHome}/lcaPlone
        EH_retOnFail

        opDo ./plone3Proc.sh  -i fullUpdateAll
    else
        ANT_raw "No ${bpoHome}/lcaPlone/ContentTree -- Skipped"
    fi
}


function vis_fullSupplementsObsoleted {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    bystarBagpLoad

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneSitePrep

    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneManagerAdd

    opDoAfterPause bystarPlone3Initial.sh -p bpoId="${bystarUid}" -i lcaPloneFullSetup
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




function vis_ploneSiteCreate {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]
    
    opDoAfterPause bystarPlone3Commands.sh ${G_commandOptions} -p bpoId="${bystarUid}" -i ploneSiteAdd

    opDoAfterPause vis_apache2SiteBasePrep

    opDoAfterPause vis_virHostPloneConfigUpdate
    opDoAfterPause vis_virHostSldPloneConfigUpdate
}

function vis_apache2SiteBasePrep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot


  opAcctInfoGet ${bystarUid}

  #FN_dirSafeKeep ${opAcct_homeDir}/lcaApache2

  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2
  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/www/htdocs
  opDoExit mkdir -p ${opAcct_homeDir}/lcaApache2/www/logs

  #opDo chown -R ${bystarUid} ${opAcct_homeDir}/lcaApache2
  opDo chown -R bystar:bisos ${opAcct_homeDir}/lcaApache2
  opDo sudo -u root chmod -R  g+w ${opAcct_homeDir}/lcaApache2
}



function vis_backupPloneSite {

  opAcctInfoGet ${bystarUid}
  
  return

  opAcctInfoGet ${iv_bap_plone_siteOwner}
  typeset backupDir=${opAcct_homeDir}/backup
  opDo  FN_dirCreatePathIfNotThere ${backupDir}
  loadFeaturesConf ${bapContainer}

  typeset constructor="/manage_exportObject"
  typeset input="-d id=${iv_name_fqdn}"
  opDo zmi_login_and_action ${iv_zopeSrv_url} ${iv_bap_plone_siteOwner} ${iv_bap_ai_currentPasswd} ${constructor} $input > ${logFile}

  opDo mv ${iv_zopeSrv_instanceDir}/var/${iv_name_fqdn}.zexp ${backupDir}/${iv_name_fqdn}.${dateTag}.zexp

  opDo ls -ld  ${backupDir}/${iv_name_fqdn}.${dateTag}.zexp

  opDo rm ${logFile}

}

function vis_serviceDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    opDo bystarPlone3Commands.sh -h -v -n showRun -p bpoId=${bystarUid} -i ploneSiteDelete

    opDo vis_virHostPloneConfigDelete

    opDo vis_virHostSldPloneConfigDelete

    lpReturn
}


function vis_removePloneSiteObsoleted {

  opAcctInfoGet ${bystarUid}
  
  typeset bapContainer="${opAcct_homeDir}/NSP/ploneFeatures.nsp"
  
  EH_assert [[ -f ${bapContainer} ]]
  this_ploneNspFile=`FN_nonDirsPart ${bapContainer}`

  if [[ "${this_ploneNspFile}_" != "ploneFeatures.nsp_" ]] ; then
    EH_problem "Wrong NSP file"
  fi

  . ${bapContainer}
  item_bap_full
  loadFeaturesConf ${bapContainer}

  opDo vis_backupPloneSite

  typeset logFile="/tmp/deactivate.$$"

  typeset constructor="/manage_delObjects"
  typeset input="-d ids:list=${iv_name_fqdn}"
  opDo zmi_login_and_action ${iv_zopeSrv_url} ${iv_zopeSrv_initialUser} ${iv_zopeSrv_initialPasswd} ${constructor} $input > ${logFile}

  ANT_raw "About to delete site owner account"
  continueAfterThis
  
  opDo lcaPloneAdmin.sh  -p adminUsername=${iv_zopeSrv_initialUser} -p adminPasswd=${iv_zopeSrv_initialPasswd}  -p username=${iv_bap_plone_siteOwner} -p siteurl=${iv_zopeSrv_url} -i deleteZopeUser > ${logFile}
 
  #typeset destConfFile="${apacheBaseDir}/servers/${opRunHostName}/conf/httpd.conf" 
  #opDo cp ${destConfFile} ${destConfFile}.${dateTag}
  #FN_blockRemoveFromLine "${iv_name_fqdn}" "VirtualHost" ${destConfFile}
  #FN_blockRemoveFromLine "web.${iv_number_fqdn}" "VirtualHost" ${destConfFile}

  opDo rm ${logFile}

}


function vis_virHostPloneConfigStdout {
  #G_abortIfNotRunningAsRoot


  bystarAcctParamsPrep

  
  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  opDo lpParamsBasicGet
  
  thisIPAddress=${lpDnsEntryIpAddr}


  dateTag=`date +%y%m%d%H%M%S`

  cat  << _EOF_
# VirtualHost for ${bystarDomFormTld_plone} Generated by ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName  ${bystarDomFormTld_plone}
    ServerAlias ${bystarDomFormTld}
    ServerAdmin webmaster@${bystarDomFormTld}

    RewriteEngine On
    RewriteRule ^/(.*) http://127.0.0.1:8080/VirtualHostBase/http/${bystarDomFormTld_plone}:80/${bystarDomFormTld}/VirtualHostRoot/\$1 [L,P]

    DocumentRoot ${opAcct_homeDir}/lcaApache2/www/htdocs
    #ScriptAlias /cgi-bin/ "${opAcct_homeDir}/lcaApache2/www/cgi-bin/"  
    ErrorLog ${opAcct_homeDir}/lcaApache2/www/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/www/logs/access_log common

        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory ${opAcct_homeDir}/lcaApache2/www/htdocs>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>
</VirtualHost>
_EOF_

}


function vis_virHostPloneConfigStdoutObsoleted {
  #G_abortIfNotRunningAsRoot


  bystarAcctParamsPrep

  
  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  opDo lpParamsBasicGet
  
  thisIPAddress=${lpDnsEntryIpAddr}


  dateTag=`date +%y%m%d%H%M%S`

  cat  << _EOF_
# VirtualHost for ${bystarDomFormTld_plone} Generated by ${G_myName} on ${dateTag}

<VirtualHost ${thisIPAddress}>
    ServerName  ${bystarDomFormTld_plone}
    ServerAlias ${bystarDomFormTld}
    ServerAdmin webmaster@${bystarDomFormTld}

    RewriteEngine On
    RewriteRule ^/(.*) http://127.0.0.1:8080/VirtualHostBase/http/${bystarDomFormTld_plone}:80/${bystarDomFormTld}/VirtualHostRoot/\$1 [L,P]

    DocumentRoot ${opAcct_homeDir}/lcaApache2/www/htdocs
    #ScriptAlias /cgi-bin/ "${opAcct_homeDir}/lcaApache2/www/cgi-bin/"  
    ErrorLog ${opAcct_homeDir}/lcaApache2/www/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/www/logs/access_log common

        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory ${opAcct_homeDir}/lcaApache2/www/htdocs>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>
</VirtualHost>
_EOF_

}


function vis_configFileNameTldGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bpoIdPrep
    bystarAcctParamsPrep
    #opAcctInfoGet ${bystarUid}

    echo "/etc/apache2/sites-available/${bystarDomFormTld_plone}.conf"

    lpReturn
}



function vis_virHostPloneConfigUpdate {
   EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  bystarAcctParamsPrep

  
  thisConfigFile=$( vis_configFileNameTldGet )

    FN_fileSafeKeep ${thisConfigFile}

    vis_virHostPloneConfigStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    #FN_fileSymlinkUpdate ${thisConfigFile} "/etc/apache2/sites-enabled/${bystarDomFormTld_plone}"
    opDo a2ensite ${bystarDomFormTld_plone}.conf

    opDo /etc/init.d/apache2 force-reload
}

function vis_virHostPloneConfigVerify {
   EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  
  #thisConfigFile="/etc/apache2/sites-available/${bystarDomFormTld_plone}"
  thisConfigFile=$( vis_configFileNameTldGet )

  typeset tmpFile=$( FN_tempFile )

  vis_virHostPloneConfigStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_virHostPloneConfigShow {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  #G_abortIfNotRunningAsRoot

  
  thisConfigFile="/etc/apache2/sites-available/${bystarDomFormTld_plone}"

  opDo ls -l ${thisConfigFile} 
}


function vis_virHostPloneConfigDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

    bystarAcctParamsPrep

    if [ "${bystarDomFormTld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormTld_plone"
        return 0
    fi

    opDo /bin/rm "/etc/apache2/sites-available/${bystarDomFormTld_plone}" "/etc/apache2/sites-enabled/${bystarDomFormTld_plone}"

    #opDo /etc/init.d/apache2 force-reload
}


function vis_virHostSldPloneConfigDelete {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

    G_abortIfNotRunningAsRoot

    bystarAcctParamsPrep

    if [ "${bystarDomFormSld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormSld_plone"
        return 0
    fi

    opDo /bin/rm "/etc/apache2/sites-available/${bystarDomFormSld_plone}" "/etc/apache2/sites-enabled/${bystarDomFormSld_plone}"

    #opDo /etc/init.d/apache2 force-reload
}



function vis_virHostSldPloneConfigStdout {
  #G_abortIfNotRunningAsRoot


  bystarAcctParamsPrep

    if [ "${bystarDomFormSld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormSld_plone"
        return 0
    fi


  
  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  opDo lpParamsBasicGet
  
  thisIPAddress=${lpDnsEntryIpAddr}

  dateTag=`date +%y%m%d%H%M%S`

  cat  << _EOF_
# VirtualHost for ${bystarDomFormTld_plone} Generated by ${G_myName}:${G_thisFunc} on ${dateTag} -- Do Not Hand Edit

<VirtualHost *:80>
    ServerName  ${bystarDomFormSld_plone}
    ServerAlias ${bystarDomFormSld}
    ServerAdmin webmaster@${bystarDomFormSld}

    RewriteEngine On
    RewriteRule ^/(.*) http://127.0.0.1:8080/VirtualHostBase/http/${bystarDomFormSld_plone}:80/${bystarDomFormTld}/VirtualHostRoot/\$1 [L,P]

    DocumentRoot ${opAcct_homeDir}/lcaApache2/www/htdocs
    #ScriptAlias /cgi-bin/ "${opAcct_homeDir}/lcaApache2/www/cgi-bin/"  
    ErrorLog ${opAcct_homeDir}/lcaApache2/www/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/www/logs/access_log common

        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory ${opAcct_homeDir}/lcaApache2/www/htdocs>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>
</VirtualHost>
_EOF_

}



function vis_virHostSldPloneConfigStdoutObsoleted {
  #G_abortIfNotRunningAsRoot


  bystarAcctParamsPrep

    if [ "${bystarDomFormSld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormSld_plone"
        return 0
    fi


  
  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  #thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  opDo lpParamsBasicGet
  
  thisIPAddress=${lpDnsEntryIpAddr}

  dateTag=`date +%y%m%d%H%M%S`

  cat  << _EOF_
# VirtualHost for ${bystarDomFormSld_plone} Generated by ${G_myName} on ${dateTag}

<VirtualHost ${thisIPAddress}>
    ServerName  ${bystarDomFormSld_plone}
    ServerAlias ${bystarDomFormSld}
    ServerAdmin webmaster@${bystarDomFormSld}

    RewriteEngine On
    RewriteRule ^/(.*) http://127.0.0.1:8080/VirtualHostBase/http/${bystarDomFormSld_plone}:80/${bystarDomFormTld}/VirtualHostRoot/\$1 [L,P]

    DocumentRoot ${opAcct_homeDir}/lcaApache2/www/htdocs
    #ScriptAlias /cgi-bin/ "${opAcct_homeDir}/lcaApache2/www/cgi-bin/"  
    ErrorLog ${opAcct_homeDir}/lcaApache2/www/logs/error_log
    CustomLog ${opAcct_homeDir}/lcaApache2/www/logs/access_log common

        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory ${opAcct_homeDir}/lcaApache2/www/htdocs>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        <Proxy *>
                Order deny,allow
                Allow from all
        </Proxy>
</VirtualHost>
_EOF_

}


function vis_configFileNameSldGet {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    #if vis_reRunAsRoot ${G_thisFunc} $@ ; then lpReturn ${globalReRunRetVal}; fi;

    EH_assert bpoIdPrep
    bystarAcctParamsPrep
    #opAcctInfoGet ${bystarUid}

    echo "/etc/apache2/sites-available/${bystarDomFormSld_plone}.conf"

    lpReturn
}



function vis_virHostSldPloneConfigUpdate {
   EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]


  G_abortIfNotRunningAsRoot

  bystarAcctParamsPrep

    if [ "${bystarDomFormSld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormSld_plone"
        return 0
    fi

  
  #thisConfigFile="/etc/apache2/sites-available/${bystarDomFormSld_plone}"
  thisConfigFile=$( vis_configFileNameSldGet )

    FN_fileSafeKeep ${thisConfigFile}

    vis_virHostSldPloneConfigStdout > ${thisConfigFile}

    opDo ls -l ${thisConfigFile}

    #FN_fileSymlinkUpdate ${thisConfigFile} "/etc/apache2/sites-enabled/${bystarDomFormSld_plone}"
    opDo a2ensite ${bystarDomFormSld_plone}.conf

    opDo /etc/init.d/apache2 force-reload
}

function vis_virHostSldPloneConfigVerify {
   EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]


  #G_abortIfNotRunningAsRoot


    if [ "${bystarDomFormSld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormSld_plone"
        return 0
    fi


  
  #thisConfigFile="/etc/apache2/sites-available/${bystarDomFormSld_plone}"
  thisConfigFile=$( vis_configFileNameSldGet )

  typeset tmpFile=$( FN_tempFile )

  vis_virHostSldPloneConfigStdout > ${tmpFile} 

  FN_fileCmpAndDiff ${thisConfigFile} ${tmpFile}
 
  FN_fileRmIfThere ${tmpFile} 
}

function vis_virHostSldPloneConfigShow {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]



  #G_abortIfNotRunningAsRoot


    if [ "${bystarDomFormSld_plone}_" == "_" ] ; then
        ANT_raw "Skipping blank  bystarDomFormSld_plone"
        return 0
    fi


  
  thisConfigFile="/etc/apache2/sites-available/${bystarDomFormSld_plone}"

  opDo ls -l ${thisConfigFile} 
}


function vis_dnsUpdate {
  EH_assert [[ $# -eq 0 ]]
  EH_assert [[ "${bystarUid}_" != "MANDATORY_" ]]

  G_abortIfNotRunningAsRoot

  opDoRet mmaDnsServerHosts.sh -i hostIsOrigContentServer

  bystarAcctParamsPrep

  opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}
    # ${opNetCfg_ipAddr} ${opNetCfg_netmask} ${opNetCfg_networkAddr} ${opNetCfg_defaultRoute}
    
  thisIPAddress=`lpL3Hosts.sh -p clusterName=${opRunClusterName} -p hostName=${opRunHostName} -i givenHostGetIPaddr`


  if [ "${bystarDomFormTld_plone}_" != "_" ] ; then
      opDoRet mmaDnsEntryAliasUpdate ${bystarDomFormTld_plone} ${opRunHostName}
  fi
  if [ "${bystarDomFormTld2_plone}_" != "_" ] ; then
      opDoRet mmaDnsEntryAliasUpdate ${bystarDomFormTld2_plone} ${opRunHostName}
  fi
  if [ "${bystarDomFormSld_plone}_" != "_" ] ; then
      opDoRet mmaDnsEntryAliasUpdate ${bystarDomFormSld_plone} ${opRunHostName}
  fi
  if [ "${bystarDomFormBynumber_plone}_" != "_" ] ; then
      opDoRet mmaDnsEntryAliasUpdate ${bystarDomFormBynumber_plone} ${opRunHostName}
  fi
  if [ "${bystarDomFormNumbered_plone}_" != "_" ] ; then
      opDoRet mmaDnsEntryAliasUpdate ${bystarDomFormNumbered_plone} ${opRunHostName}
  fi
  if [ "${bystarDomFormNumberedSld_plone}_" != "_" ] ; then
      opDoRet mmaDnsEntryAliasUpdate ${bystarDomFormNumberedSld_plone} ${opRunHostName}
  fi

  opDo ls -l /etc/tinydns/origContent/data.origZones  1>&2

}



function vis_dnsDelete {

  opDoExit mmaDnsServerHosts.sh -i hostIsOrigContentServer

  integer gotVal=0
  bynameAcctAnalyze || gotVal=$?

  if [[ ${gotVal} -eq 0 ]] ; then

    opDoExit opNetCfg_paramsGet ${opRunClusterName} ${opRunHostName}

    opDoRet mmaDnsEntryMxUpdate ${byname_acct_baseDomain} ${opRunHostName}
    opDoRet mmaDnsEntryMxUpdate ${byname_acct_numberDomain} ${opRunHostName}
  else
    EH_problem "$0: not enough info."
    return 1
  fi
}


function RbaeCompatibiltyObsoleted {
    EH_assert [[ $# -eq 1 ]]

    baseDir=$1
    
    opDo fileParamsCodeGenToFile  ${baseDir}

    # /libre/ByStar/InfoBase/RBAE/BYSMB/ea/59040/cpf_59040.sh 
    opDo fileParamsLoadVarsFromBaseDir  ${baseDir}

  assignedUserIdNumber="${cp_acctNu}"
  FirstName="${cp_Domain2}"
  LastName="${cp_Domain1}"
  emailAdmin="${cp_AdminContactEmail}"
  companyName="${cp_CompanyName}"
  businessType="${cp_BusinessType}"
  domainName="${cp_Domain2}"
  domainNameExt="${cp_Domain1}"
  contactPerson="${cp_AdminContactPerson}"
  domainHost="${cp_acctFactoryBaseDomain}"
  hostName="${cp_BacsId}"
  DomainRel="${cp_DomainRel}"
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
