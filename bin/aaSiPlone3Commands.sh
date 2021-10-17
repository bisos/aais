#!/bin/bash

####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] |
"
FILE="
*  /This File/ :: /bisos/git/auth/bxRepos/bisos/aais/bin/bystarPlone3Admin.sh
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@"
    exit $?
fi
####+END:


vis_help () {
  cat  << _EOF_

NEXT:
   - Exclude from navigation -- for /images /PLPC ...

TODO:

   For description and title, also support description_enc and title_enc
   which first run uriDecode.sh on the _enc params 

   - ExternalFile Replacement -- ATManagedFile

   - Shared with Examples create basic inputFile
   - Layer pageFull and folderFull
   - Deal with index_html being special
   - Make PlatformParameters (user/passwd) come from functions


_EOF_
}

. ${opBinBase}/bystarHook.libSh

# bystarLib.sh
. ${opBinBase}/bystarLib.sh

# ./lcaPlone3.libSh
. ${opBinBase}/lcaPlone3.libSh

. ${opBinBase}/unisosAccounts_lib.sh
. ${opBinBase}/bisosGroupAccount_lib.sh
. ${opBinBase}/bisosAccounts_lib.sh

. ${opBinBase}/bisosCurrents_lib.sh

# mmaLayer3Lib.sh 
#. ${opBinBase}/mmaLayer3Lib.sh

# bystarDnsDomain.libSh  
#. ${opBinBase}/bystarDnsDomain.libSh

#. ${opBinBase}/bystarInfoBase.libSh

# bystarHereAcct.libSh
#. ${opBinBase}/bystarHereAcct.libSh
. ${aaisBinBase}/aaisCommon_lib.sh

# PRE parameters
typeset -t acctTypePrefix=""
# typeset -t bpoId=""

typeset -t si=""      # Service Instance
typeset -t bpoId=""   # aaisBpo


function G_postParamHook {
    if [ ! -z "${bpoId}" ] ; then
        # bpoIdPrep
        bpoHome=$( FN_absolutePathGet ~${bpoId} )
    fi

    bisosCurrentsGet

    #containerZopeUser=$( bystarHereAcctContainerPlone3UserGet )
    #containerZopePasswd=$( bystarHereAcctContainerPlone3PasswdGet )
    #containerZopeBaseUrl=$( bystarHereAcctContainerPlone3BaseUrlGet )

    oneInputFile="/tmp/oneInput.html"
}

function G_runPrep {
  vis_pageHtmlExample 2> /dev/null 1> ${oneInputFile}
}


function vis_examples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  # NOTYET, outofdate
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`

  typeset thisAcctTypePrefix="sa"
  #typeset thisOneSaNu="sa-20051"
  #typeset thisOneSaNu=${oneBystarAcct}
  typeset thisOneSaNu=aaisByDomain
  typeset oneSubject="qmailAddr_test"


  typeset oneFolderPath="/test1"
  typeset oneFilePath="index_html"

  typeset oneTitle="Some+Title"
  typeset oneDescription="Some+Description"


 cat  << _EOF_
EXAMPLES:
${doLibExamples}
====== See Also, Usage ====
bystarPlone3Admin.sh
bystarPlone3Features.sh
======  Zope/Plone Site Commands  ======
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneSiteAdd
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneSiteDelete  # par.live needs to be current for this
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneSitePrep
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneSiteMailhost
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneSiteSecurity
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneProductsAdd
======  Plone User Commands  ======
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneManagerAdd
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneUserAdd
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneUserRoleSet
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -i ploneSiteAuthenticatorGet
======  FTP Layer Commands  =======
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p inputFile="${oneInputFile}" -i ftpFileUpload
======  Folder Manipulation Commands  ======
---- FTP Folder Add ----
${G_myName} -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -i ftpFolderAdd
---- Folder Publish - Set Title ----
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}"  -i folderState publish
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}"  -i folderState retract
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="images"  -p title="images"  -p description="images" -i folderExcludeFromNav true
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="images"  -p title="images"  -p description="images" -i folderExcludeFromNav false
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}"  -p title="${oneTitle}"  -p description="${oneDescription}" -i folderTitleSet
---- Folder Create - add+publish+setTitle ----
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}"  -p title="${oneTitle}"  -p description="${oneDescription}" -i folderCreate
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}"  -i folderCreateParents
======  Page Manipulation Commands  =======
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i pageUploadHtmlAndPublish
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="${oneInputFile}" -i pageUploadHtml
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -i pageState publish
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -i pageState retract
======  Link Redirect Commands  =======
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p linkDest="http://www.neda.com" -i linkAddAndPublish
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p linkDest="http://www.neda.com" -i linkAdd
======  File Manipulation Commands  =======
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="/opt/public/osmt/samples/pdf/small.pdf" -i fileUploadAndPublish
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu} -p siteFolder="${oneFolderPath}" -p sitePage="${oneFilePath}" -p title="${oneTitle}"  -p description="${oneDescription}" -p inputFile="/opt/public/osmt/samples/pdf/small.pdf" -i fileUpload
======   External File Sync Tree =====
${G_myName}  -p uid=any ${extraInfo} -p bpoId=${thisOneSaNu} -p path="/content/generated/doc.free/neda/PLPC/110001/current"  -i pathSyncTree
======  Misc  =======
${G_myName} ${extraInfo} -p bpoId=${thisOneSaNu}  -i pageHtmlExample
${G_myName} ${extraInfo} -i developerExamples
_EOF_
}


function vis_developerExamples {
  typeset extraInfo="-h -v -n showRun"
  #typeset extraInfo=""
  typeset doLibExamples=`doLibExamplesOutput ${G_myName}`
 cat  << _EOF_
EXAMPLES:
${doLibExamples}
======  Factory Utilities  ======
${G_myName} -p uid=any ${extraInfo} -i factoryTimeStamp
${G_myName} -p uid=any ${extraInfo} -i kukitTimeStamp
uriEncode.sh  "http://www.neda.com/some space/kk"
uriDecode.sh http%3A%2F%2Fwww.neda.com%2Fx%20%25%20j
_EOF_
}

noArgsHook() {
  vis_examples
}

noSubjectHook() {
  return 0
}


function bystarPlone3ContainerZopeParamsPrep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

  containerZopeUser=$( bystarHereAcctContainerPlone3UserGet )
  containerZopePasswd=$( bystarHereAcctContainerPlone3PasswdGet )

  containerZopeBaseUrl=$( bystarHereAcctContainerPlone3BaseUrlGet )
}



function vis_factoryTimeStamp {
    EH_assert [[ $# -eq 0 ]]
    
    date +%Y-%m-%d.%N
}

function vis_kukitTimeStamp {
    EH_assert [[ $# -eq 0 ]]
    
    date +%N
}



function vis_ploneSiteAuthenticatorGet {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


  opAcctInfoGet ${bpoId}

  bystarDomainFormsPrep

  typeset logFile="/tmp/zmiAutoLogin.$$"

  eval curl --user ${containerZopeUser}:${containerZopePasswd} -k -i -o ${logFile} http://${bystarDomFormTld_plone}/join_form 

  grep _authenticator ${logFile} | sed -e 's/.*value="//' -e 's/".*$//'
}


function vis_ploneSiteAuthenticatorGetBystarUid {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


  opAcctInfoGet ${bpoId}

  bystarDomainFormsPrep

  typeset logFile="/tmp/zmiAutoLogin.$$"

  eval curl --user   ${cp_acctPrefix}${cp_acctNu}:${bpoIdPasswdDecrypted} -k -i -o ${logFile} http://${bystarDomFormTld_plone}/join_form

  grep _authenticator ${logFile} | sed -e 's/.*value="//' -e 's/".*$//'
}

function vis_ploneSiteAdd {
    G_funcEntry
    function describeF {  cat  << _EOF_
_EOF_
    }
    EH_assert [[ $# -eq 0 ]]
    EH_assert [ -n "${bpoId}" ]
    EH_assert [ -n "${si}" ]

    lpDo loadSiParams "${bpoId}" "${si}"

    lpDo bystarPlone3ContainerZopeParamsPrep

    opDo echo lcaPlone3UrlApi.sh ${containerZopeUser} ${containerZopePasswd} ${containerZopeBaseUrl} \
        /manage_addProduct/CMFPlone/addPloneSite \
        -d id=${cp_acctMainBaseDomain} \
        -d title=${cp_acctMainBaseDomain} \
        -d create_userfolder=1 \
        -d description="The+Web+Site+Of+${cp_acctMainBaseDomain}" \
        -d submit=+Add+Plone+Site+

 # NOTYET, Check the error code, if error, check the error values

}


function vis_ploneSiteDelete {
    G_funcEntry
    function describeF {  cat  << _EOF_
${G_myName}:${G_thisFunc}: 

Manual Procedure:
  1) Hit http://localhost:8080/manage
  2) Enter admin and passwd  -- lcaPlone3Config.sh -i hereContainerPlone3PasswdGet
  3) Click on desired site
  4) Delete
  5) Zope Quick Start -- Logout

Script: Subject the above to http capture and produce lcaPlone3UrlApi.sh params
See Also: bystarPlone3Commands.sh -i removePloneSite

livehttpheader capture
http://localhost:8080/manage_main
ids%3Alist=freeprotocols.org&manage_delObjects%3Amethod=Delete
_EOF_
    }

    #opDo describeF

    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


    opAcctInfoGet ${bpoId}

    bystarDomainFormsPrep

    ploneSiteName=${bystarDomFormTld}

    opDo lcaPlone3UrlApi.sh ${containerZopeUser} ${containerZopePasswd} http://${bystarDomFormTld_plone}:8080 \
        / \
        -d ids%3Alist=${ploneSiteName} \
        -d manage_delObjects%3Amethod=Delete

    lpReturn
}




function vis_ploneSitePrep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


  opAcctInfoGet ${bpoId}

  #vis_ploneSiteMailhost

  opDo vis_ploneSiteSecurity

  opDo vis_ploneProductsAdd
}

function vis_ploneSiteMailhost {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


    opAcctInfoGet ${bpoId}

    bystarDomainFormsPrep

    ploneAuth=$( vis_ploneSiteAuthenticatorGet 2> /dev/null )

    echo ploneAuth=${ploneAuth}
  
    opDo lcaPlone3UrlApi.sh ${containerZopeUser} ${containerZopePasswd} http://${bystarDomFormTld_plone} \
        /@@mail-controlpanel \
       -F fieldset.current= \
       -F form.smtp_host=localhost \
       -F form.smtp_port=587 \
       -F form.smtp_userid=${bpoId} \
       -F form.smtp_pass="${bpoIdPasswdDecrypted}" \
       -F form.email_from_name="PloneSite" \
       -F form.email_from_address=web@${cp_acctMainBaseDomain} \
       -F form.actions.save=Save \
       -F _authenticator=${ploneAuth}

}



function vis_ploneSiteSecurity {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


    opAcctInfoGet ${bpoId}

    bystarDomainFormsPrep

    ploneAuth=$( vis_ploneSiteAuthenticatorGet 2> /dev/null )

    echo ploneAuth=${ploneAuth}
  
    opDo lcaPlone3UrlApi.sh ${containerZopeUser} ${containerZopePasswd} http://${bystarDomFormTld_plone} \
        /@@security-controlpanel \
       -F fieldset.current= \
       -F form.enable_self_reg.used= \
       -F form.enable_user_pwd_choice.used= \
       -F form.enable_user_pwd_choice=on \
       -F form.enable_user_folders.used= \
       -F form.allow_anon_views_about.used= \
       -F form.actions.save=Save \
       -F _authenticator=${ploneAuth}

}


function vis_ploneManagerAdd {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    vis_ploneUserAdd

    vis_ploneUserRoleSet # manager
}

# /join_form last_visit%3Adate=2009%2F12%2F20+13%3A42%3A42.985+US%2FPacific&prev_visit%3Adate=2009%2F12%2F20+13%3A42%3A42.985+US%2FPacific&came_from_prefs=1&fullname=ea-01&username=ea01&email=mohsen.banan%40byname.net&password=changeme&password_confirm=changeme&mail_me=on&form.button.Register=Register&form.submitted=1&_authenticator=5d602059fad7ead4691a5cb7b17adfd3e4721358

function vis_ploneUserAdd {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


  opAcctInfoGet ${bpoId}

  bystarDomainFormsPrep

  ploneAuth=$( vis_ploneSiteAuthenticatorGet 2> /dev/null )

  echo ploneAuth=${ploneAuth}
  
 opDo lcaPlone3UrlApi.sh ${containerZopeUser} ${containerZopePasswd} http://${bystarDomFormTld_plone} \
     /join_form \
     -d last_visit%3Adate=2009%2F12%2F20+13%3A42%3A42.985+US%2FPacific \
     -d prev_visit%3Adate=2009%2F12%2F20+13%3A42%3A42.985+US%2FPacific \
     -d came_from_prefs=1 \
     -d fullname=${cp_acctUid} \
     -d username=${cp_acctPrefix}${cp_acctNu} \
     -d email=mohsen.banan%40byname.net \
     -d password=${bpoIdPasswdDecrypted} \
     -d password_confirm=${bpoIdPasswdDecrypted} \
     -d mail_me=on \
     -d form.button.Register=Register \
     -d form.submitted=1 \
     -d _authenticator=${ploneAuth}



 # NOTYET, Check the error code, if error, check the error values

}



# NOTYET, the line below from manage-portlets-> add-> login
#POST / referer=http%3A%2F%2Fwww.libresite.org%2F%40%40manage-portlets&%3Aaction=%2F%2B%2Bcontextportlets%2B%2Bplone.leftcolumn%2F%2B%2Fportlets.Login



# POST /prefs_users_overview form.submitted=1&searchstring=ea-01&users.id%3Arecords=ea01&users.email%3Arecords=mohsen.banan%40byname.net&users.roles%3Alist%3Arecords=Member&users.roles%3Alist%3Arecords=Manager&form.button.Modify=Apply+Changes&_authenticator=5d602059fad7ead4691a5cb7b17adfd3e4721358



# NOTYET, arg1=manager

function vis_ploneUserRoleSet {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    bystarBagpLoad


  opAcctInfoGet ${bpoId}

  bystarDomainFormsPrep

  ploneAuth=$( vis_ploneSiteAuthenticatorGet 2> /dev/null )

  echo ploneAuth=${ploneAuth}

 opDo lcaPlone3UrlApi.sh \
     ${containerZopeUser} \
     ${containerZopePasswd} \
     http://${bystarDomFormTld_plone} \
     /prefs_users_overview \
     -d form.submitted=1 \
     -d searchstring=${cp_acctUid} \
     -d users.id%3Arecords=${cp_acctPrefix}${cp_acctNu} \
     -d users.email%3Arecords=mohsen.banan%40byname.net \
     -d users.roles%3Alist%3Arecords=Member \
     -d users.roles%3Alist%3Arecords=Manager \
     -d form.button.Modify=Apply+Changes \
     -d _authenticator=${ploneAuth}

 # NOTYET, Check the error code, if error, check the error values
}


# POST /portal_quickinstaller/installProducts products%3Alist=plone.app.blob

function vis_ploneProductsAdd {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]


    bystarAcctParamsPrep

    opDo lcaPlone3UrlApi.sh \
        ${containerZopeUser} \
        ${containerZopePasswd} \
        http://${bystarDomFormTld_plone} \
        /portal_quickinstaller/installProducts \
        -d products%3Alist=plone.app.blob

 # NOTYET, Check the error code, if error, check the error values
}


#
# FTP Layer Interface
#

function vis_ftpFileUpload {
#set -x
    # Generally Used for Updates, 
    # Does not set title, description or publish

    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]

    EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]


   bystarAcctParamsPrep

  siteFqdn="${bystarDomFormTld_plone}"

  #userName=${cp_acctPrefix}${cp_acctNu}
  userName=${containerZopeUser}
  #password=${bpoIdPasswdDecrypted}
  password=${containerZopePasswd}

  #ANT_raw "pftping ${inputFile} to /${bystarDomFormTld}${siteFolder}/${sitePage} -- pftp -n ${siteFqdn} 8021 ${userName} ${password}"
  ANT_raw "pftping ${inputFile} to /${bystarDomFormTld}${siteFolder}/${sitePage} -- pftp -n ${siteFqdn} 8021 ${userName}"

#set -x
  pftp -n ${siteFqdn} 8021 << _EOF_
  quote USER ${userName}
  quote PASS ${password}
  binary
  cd /${bystarDomFormTld}${siteFolder}
  put ${inputFile} ${sitePage}
  bye
_EOF_

}


function vis_ftpFolderAdd {
#set -x
    # Generally Used for Updates, 
    # Does not set title, description or publish

    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

   EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

  siteFqdn="${bystarDomFormTld_plone}"

  #userName=${cp_acctPrefix}${cp_acctNu}
  userName=${containerZopeUser}
  #password=${bpoIdPasswdDecrypted}
  password=${containerZopePasswd}

  ANT_raw "pftping mkdir /${bystarDomFormTld}${siteFolder} -- pftp -n ${siteFqdn} 8021"


  pftp -n ${siteFqdn} 8021 << _EOF_
  quote USER ${userName}
  quote PASS ${password}
  mkdir /${bystarDomFormTld}${siteFolder}
  bye
_EOF_

}

#
# Folder Layer Interface
#

function vis_folderState  {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]

    stateCommand=$1

  case ${stateCommand} in
    "publish"|"retract")
          doNothing
       ;;
     *)
       EH_problem "Unexpected stateCommand=${stateCommand}"
       return 1
       ;;
  esac


#/test1/content_status_modify?workflow_action=publish

   bystarAcctParamsPrep

  opDo lcaPlone3UrlApi.sh \
      ${cp_acctPrefix}${cp_acctNu} \
      ${bpoIdPasswdDecrypted} \
      http://${bystarDomFormTld_plone} \
      ${siteFolder}/content_status_modify?workflow_action=${stateCommand}
}

function vis_folderTitleSet {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]

    bystarAcctParamsPrep


    ploneAuth=$( vis_ploneSiteAuthenticatorGet 2> /dev/null )

    #echo ploneAuth=${ploneAuth}
  
#POST /Resume/folder_rename_form form.submitted=1&orig_template=http%3A%2F%2Fwww.test860.com%2FResume&paths%3Alist=%2Ftest860.com%2FResume&new_ids%3Alist=Resume&new_titles%3Alist=Resume&form.button.RenameAll=Rename+All&_authenticator=7562761956d61aa937ca7d944d13aac0f1d42bb3

   #urlEncTitle=$( uriEncode.sh ${title} )
    urlEncTitle=${title}
   urlEncPath=$( uriEncode.sh http://${bystarDomFormTld_plone}${siteFolder} )


   # Note user containerZopeUser because of how folder was created.

   opDo lcaPlone3UrlApi.sh \
       ${containerZopeUser} \
       ${containerZopePasswd} \
       http://${bystarDomFormTld_plone} \
       /${siteFolder}/folder_rename_form \
       -d form.submitted=1 \
       -d orig_template=${urlEncPath} \
       -d paths%3Alist=$( uriEncode.sh "/${bystarDomFormTld}${siteFolder}" ) \
       -d new_ids%3Alist=$( FN_nonDirsPart ${siteFolder} ) \
       -d new_titles%3Alist="${urlEncTitle}" \
       -d form.button.RenameAll=Rename+All \
       -d _authenticator=${ploneAuth}

}



function vis_folderExcludeFromNav {

    EH_assert [[ $# -eq 1 ]]

    excludeFromNavArg=$1

    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]

    bystarAcctParamsPrep

    if [[ "${excludeFromNavArg}" == "true" ]] ; then
        excludeFromNavStr=" -F excludeFromNav:boolean=on"
    elif [[ "${excludeFromNavArg}" == "false" ]] ; then
        excludeFromNavStr=" -F excludeFromNav:boolean=off"
        ANT_raw "NOTYET: excludeFromNavArg=false does not work. No Action Taken"
        lpReturn 0
    else
        EH_problem "Bad Required Arg: ${excludeFromNavArg}"
        return 101
    fi

    # Strip One Leading Slash
    siteFolderId=${siteFolder##/}

    opDo lcaPlone3UrlApi.sh \
        ${containerZopeUser} \
        ${containerZopePasswd} \
        http://${bystarDomFormTld_plone} \
        ${siteFolder}/atct_edit \
        -F id=${siteFolderId} \
        -F title=${title} \
        -F description=${description} \
        -F description_text_format=text/plain \
        -F subject_keywords:lines= \
        -F subject_existing_keywords:default:list= \
        -F location= \
        -F language= \
        -F effectiveDate="2010/01/06 22:00:00 US/Pacific" \
        -F effectiveDate_year=2010 \
        -F effectiveDate_month=01 \
        -F effectiveDate_day=06 \
        -F effectiveDate_hour=10 \
        -F effectiveDate_minute=00 \
        -F effectiveDate_ampm=PM \
        -F expirationDate= \
        -F expirationDate_year=0000 \
        -F expirationDate_month=00 \
        -F expirationDate_day=00 \
        -F expirationDate_hour=12 \
        -F expirationDate_minute=00 \
        -F expirationDate_ampm=AM \
        -F creators:lines=${cp_acctPrefix}${cp_acctNu} \
        -F contributors:lines= \
        -F rights= \
        -F rights_text_format=text/html \
        -F allowDiscussion:boolean:default= \
        ${excludeFromNavStr}  \
        -F nextPreviousEnabled:boolean:default= \
        -F fieldsets:list=default \
        -F fieldsets:list=categorization \
        -F fieldsets:list=dates \
        -F fieldsets:list=ownership \
        -F fieldsets:list=settings \
        -F form.submitted=1 \
        -F add_reference.field:record= \
        -F add_reference.type:record= \
        -F add_reference.destination:record= \
        -F last_referer=${bystarDomFormTld_plone}/${siteFolder}/folder_contents \
        -F form.button.save=Save \
        --trace /tmp/trace.$$  

        # Used to be ${excludeFromNavStr} -F excludeFromNav:boolean:default= \

    opDo ls -l /tmp/trace.$$  

 }



function vis_folderTitleSetKeep {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]

    bystarAcctParamsPrep

#POST /Bio/kssValidateField?kukitTimeStamp=1263887232840 fieldname=title&value=Bio
#POST /Bio/kssValidateField?kukitTimeStamp=1263887243571 fieldname=description&value=Description%20for%20Bio
#POST /Bio/atct_edit -----------------------------1432064339147196525911306036

   thisKukitTimeStamp=$( vis_kukitTimeStamp )
   urlEncTitle=$( uriEncode.sh ${title} )

   opDo lcaPlone3UrlApi.sh \
       ${cp_acctPrefix}${cp_acctNu} \
       ${bpoIdPasswdDecrypted} \
       http://${bystarDomFormTld_plone} \
       /${siteFolder}/kssValidateField?kukitTimeStamp=${thisKukitTimeStamp} \
       -d fieldname=title \
       -d value=${urlEncTitle}


   thisKukitTimeStamp=$( vis_kukitTimeStamp )
   urlEncDescription=$( uriEncode.sh ${description} )

   opDo lcaPlone3UrlApi.sh \
       ${cp_acctPrefix}${cp_acctNu} \
       ${bpoIdPasswdDecrypted} \
       http://${bystarDomFormTld_plone} \
       /${siteFolder}/kssValidateField?kukitTimeStamp=${thisKukitTimeStamp} \
       -d fieldname=description \
       -d value=${urlEncDescription}


    opDo lcaPlone3UrlApi.sh \
        ${cp_acctPrefix}${cp_acctNu} \
        ${bpoIdPasswdDecrypted} \
        http://${bystarDomFormTld_plone} \
        ${siteFolder}/atct_edit \
        -F id=${siteFolder} \
        -F title=${title} \
        -F description=${description} \
        -F description_text_format=text/plain \
        -F subject_keywords:lines= \
        -F subject_existing_keywords:default:list= \
        -F location= \
        -F language= \
        -F effectiveDate="2010/01/06 22:00:00 US/Pacific" \
        -F effectiveDate_year=2010 \
        -F effectiveDate_month=01 \
        -F effectiveDate_day=06 \
        -F effectiveDate_hour=10 \
        -F effectiveDate_minute=00 \
        -F effectiveDate_ampm=PM \
        -F expirationDate= \
        -F expirationDate_year=0000 \
        -F expirationDate_month=00 \
        -F expirationDate_day=00 \
        -F expirationDate_hour=12 \
        -F expirationDate_minute=00 \
        -F expirationDate_ampm=AM \
        -F creators:lines=${cp_acctPrefix}${cp_acctNu} \
        -F contributors:lines= \
        -F rights= \
        -F rights_text_format=text/html \
        -F allowDiscussion:boolean:default= \
        -F excludeFromNav:boolean:default= \
        -F nextPreviousEnabled:boolean:default= \
        -F fieldsets:list=default \
        -F fieldsets:list=categorization \
        -F fieldsets:list=dates \
        -F fieldsets:list=ownership \
        -F fieldsets:list=settings \
        -F form.submitted=1 \
        -F add_reference.field:record= \
        -F add_reference.type:record= \
        -F add_reference.destination:record= \
        -F last_referer=${bystarDomFormTld_plone}/${siteFolder}/folder_contents \
        -F form.button.save=Save

 }



function vis_folderCreate {
    #set -x
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]

    # NOTYET, is inputFile used?
    #EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]

    # if not fast
    #G_runPrep

    sitePage=index_html

    bystarAcctParamsPrep

    opDo vis_ftpFolderAdd

    opDo vis_folderState publish

    opDo vis_folderTitleSet

}


function vis_folderCreateParents {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]

    bystarAcctParamsPrep

    sitePage=index_html

  set -- $(IFS="/"; echo ${siteFolder})
  typeset listDir="$*"
  typeset oneDir
  typeset curPath=""
  for oneDir in ${listDir} ; do
      curPath="${curPath}/${oneDir}"
      siteFolder=${curPath}
      title=${oneDir}
      description=${oneDir}

    opDo vis_ftpFolderAdd

    opDo vis_folderState publish

    opDo vis_folderTitleSet
  done
}

function vis_noPortletsForFolder {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]

    opDo bystarPlone3Portlets.sh -h -v -n showRun -p bpoId=${bpoId} -p siteFolder="${siteFolder}" -i ploneManagePortletsLeft absent

    opDo bystarPlone3Portlets.sh -h -v -n showRun -p bpoId=${bpoId} -p siteFolder="${siteFolder}" -i ploneManagePortletsRight absent
}


function vis_pageHtmlExample {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    #EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    #EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]
    #EH_assert [[ "${title}_" != "MANDATORY_" ]]
    #EH_assert [[ "${description}_" != "MANDATORY_" ]]
    #EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]

    bystarAcctParamsPrep

    pageHtmlExampleStdout () {
  cat  << _EOF_
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title></title>
<meta name="generator" content="HTML::TextToHTML v2.51"/>
</head>

<body>

<p>
This is a sample page generated by vis_pageHtmlExample 
</p>

id: ${sitePage}
title: ${title}
description: ${description}


</body>
</html>
_EOF_
    }

    pageHtmlExampleStdout
}

#
# Page Layer Interface
#

function vis_pageUploadHtml {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]
    #EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

   titleDec=$( uriDecode.sh ${title} )

    ploneItemHeaderStdout () {
  cat  << _EOF_
id: ${sitePage}
title: ${titleDec}
description: ${description}
subject: 
relatedItems: 
location: 
language: 
effectiveDate: 2009/12/27 00:59:11.365 US/Pacific
expirationDate: None
creation_date: 2009/12/27 00:54:58.241 US/Pacific
modification_date: 2009/12/27 00:59:11.366 US/Pacific
creators: ${cp_acctPrefix}${cp_acctNu}
contributors: 
rights: 
allowDiscussion: False
excludeFromNav: False
presentation: False
tableContents: False
Content-Type: text/html

_EOF_
    }


    if [ ! -f ${inputFile} ] ; then 
        EH_problem "Missing ${inputFile}" 
        return 101
    fi

    typeset tmpFile="/tmp/${G_myName}.$$"

    ploneItemHeaderStdout > ${tmpFile}

    cat ${inputFile} >> ${tmpFile}

    typeset inputFileKept=${inputFile}

    inputFile=${tmpFile}

    opDo vis_ftpFileUpload
    
    inputFile=${inputFileKept}
}

function vis_linkAdd {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]
    #EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${linkDest}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

#POST /PLPC/portal_factory/Link/link.2010-01-18.3190748897/kssValidateField?kukitTimeStamp=1263870347822 fieldname=title&value=333
#POST /PLPC/portal_factory/Link/link.2010-01-18.3190748897/kssValidateField?kukitTimeStamp=1263870360912 fieldname=description&value=PLPC-333%20title%20and%20desc
#POST /PLPC/portal_factory/Link/link.2010-01-18.3190748897/kssValidateField?kukitTimeStamp=1263870378472 fieldname=remoteUrl&value=http%3A%2F%2Fwww.neda.com
#POST /PLPC/portal_factory/Link/link.2010-01-18.3190748897/atct_edit -----------------------------84563594259275481591574299


   thisFactoryTimeStamp=$( vis_factoryTimeStamp )

   thisKukitTimeStamp=$( vis_kukitTimeStamp )
   urlEncTitle=$( uriEncode.sh ${title} )

   opDo lcaPlone3UrlApi.sh \
       ${cp_acctPrefix}${cp_acctNu} \
       ${bpoIdPasswdDecrypted} \
       http://${bystarDomFormTld_plone} \
       /${siteFolder}/portal_factory/Link/link.${thisFactoryTimeStamp}/kssValidateField?kukitTimeStamp=${thisKukitTimeStamp} \
       -d fieldname=title \
       -d value=${sitePage}


   thisKukitTimeStamp=$( vis_kukitTimeStamp )
   urlEncDescription=$( uriEncode.sh ${description} )

   opDo lcaPlone3UrlApi.sh \
       ${cp_acctPrefix}${cp_acctNu} \
       ${bpoIdPasswdDecrypted} \
       http://${bystarDomFormTld_plone} \
       /${siteFolder}/portal_factory/Link/link.${thisFactoryTimeStamp}/kssValidateField?kukitTimeStamp=${thisKukitTimeStamp} \
       -d fieldname=description \
       -d value=${urlEncDescription}


   thisKukitTimeStamp=$( vis_kukitTimeStamp )
   urlEncLinkDest=$( uriEncode.sh ${linkDest} )

   opDo lcaPlone3UrlApi.sh \
       ${cp_acctPrefix}${cp_acctNu} \
       ${bpoIdPasswdDecrypted} \
       http://${bystarDomFormTld_plone} \
       /${siteFolder}/portal_factory/Link/link.${thisFactoryTimeStamp}/kssValidateField?kukitTimeStamp=${thisKukitTimeStamp} \
       -d fieldname=remoteUrl \
       -d value=${urlEncLinkDest}


    opDo lcaPlone3UrlApi.sh \
        ${cp_acctPrefix}${cp_acctNu} \
        ${bpoIdPasswdDecrypted} \
        http://${bystarDomFormTld_plone} \
        ${siteFolder}/portal_factory/Link/link.${thisFactoryTimeStamp}/atct_edit \
        -F id=link.${thisFactoryTimeStamp} \
        -F title=${sitePage} \
        -F description=${description} \
        -F description_text_format=text/plain \
        -F remoteUrl="${linkDest}" \
        -F subject_keywords:lines= \
        -F subject_existing_keywords:default:list= \
        -F relatedItems:default:list= \
        -F location= \
        -F language= \
        -F effectiveDate="" \
        -F effectiveDate_year=0000 \
        -F effectiveDate_month=00 \
        -F effectiveDate_day=00 \
        -F effectiveDate_hour=12 \
        -F effectiveDate_minute=00 \
        -F effectiveDate_ampm=AM \
        -F expirationDate= \
        -F expirationDate_year=0000 \
        -F expirationDate_month=00 \
        -F expirationDate_day=00 \
        -F expirationDate_hour=12 \
        -F expirationDate_minute=00 \
        -F expirationDate_ampm=AM \
        -F creators:lines=${cp_acctPrefix}${cp_acctNu} \
        -F contributors:lines= \
        -F rights= \
        -F rights_text_format=text/html \
        -F allowDiscussion:boolean:default= \
        -F excludeFromNav:boolean:default= \
        -F cmfeditions_version_comment= \
        -F fieldsets:list=default \
        -F fieldsets:list=categorization \
        -F fieldsets:list=dates \
        -F fieldsets:list=ownership \
        -F fieldsets:list=settings \
        -F form.submitted=1 \
        -F add_reference.field:record= \
        -F add_reference.type:record= \
        -F add_reference.destination:record= \
        -F last_referer=${bystarDomFormTld_plone}/${siteFolder}/folder_contents \
        -F form.button.save=Save

}



function vis_linkAddFtpUntested {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]
    #EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${linkDest}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep


    ploneLinkAddStdout () {
  cat  << _EOF_
id: ${sitePage}
title: ${title}
description: ${description}
subject: 
relatedItems: 
location: 
language: 
effectiveDate: 2010/01/18 18:29:24.138 US/Pacific
expirationDate: None
creation_date: 2010/01/18 18:29:02.815 US/Pacific
modification_date: 2010/01/18 18:29:24.139 US/Pacific
creators: user
contributors: 
rights: 
allowDiscussion: False
excludeFromNav: False
Content-Type: text/plain

${linkDest}

_EOF_
    }


    typeset tmpFile="/tmp/${G_myName}.$$"

    ploneLinkAddStdout > ${tmpFile}

    inputFile=${tmpFile}

    opDo vis_ftpFileUpload
}


function vis_pageState  {
    EH_assert [[ $# -eq 1 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]

    stateCommand=$1

  case ${stateCommand} in
    "publish"|"retract")
          doNothing
       ;;
     *)
       EH_problem "Unexpected stateCommand=${stateCommand}"
       return 1
       ;;
  esac


#/test1/content_status_modify?workflow_action=publish

   bystarAcctParamsPrep

  opDo lcaPlone3UrlApi.sh \
      ${cp_acctPrefix}${cp_acctNu} \
      ${bpoIdPasswdDecrypted} \
      http://${bystarDomFormTld_plone} \
      ${siteFolder}/${sitePage}/content_status_modify?workflow_action=${stateCommand}
}


function vis_pageUploadHtmlAndPublish {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    #EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

    G_runPrep

    opDo vis_pageUploadHtml

    opDo vis_pageState publish
}

function vis_linkAddAndPublish {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    #EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${linkDest}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

    opDo vis_linkAdd

    opDo vis_pageState publish
}


function vis_fileUpload {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]
    EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

    if [ ! -f ${inputFile} ] ; then 
        EH_problem "Missing ${inputFile}" 
        return 101
    fi

    opDo vis_ftpFileUpload

}

function vis_fileUploadAndPublish {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]

    EH_assert [[ "${siteFolder}_" != "MANDATORY_" ]]
    EH_assert [[ "${title}_" != "MANDATORY_" ]]
    EH_assert [[ "${description}_" != "MANDATORY_" ]]
    EH_assert [[ "${inputFile}_" != "MANDATORY_" ]]
    EH_assert [[ "${sitePage}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

    if [ ! -f ${inputFile} ] ; then 
        EH_problem "Missing ${inputFile}" 
        return 101
    fi

    opDo vis_ftpFileUpload

    opDo vis_pageState publish
}



function vis_pathSyncTree {
    EH_assert [[ $# -eq 0 ]]
    EH_assert [[ "${bpoId}_" != "MANDATORY_" ]]
    EH_assert [[ "${path}_" != "MANDATORY_" ]]

   bystarAcctParamsPrep

    
  if [[ ! -d $path ]]; then 
    EH_problem "Missing $path"
    return 1
  fi

  treeFilesList=`find $path -print`

  for oneItem in ${treeFilesList} ; do

    if [[ -f ${oneItem} ]]; then
      dirName=`FN_dirsPart ${oneItem}`
      fileExtension=`FN_extension ${oneItem}`
      fileName=`FN_nonDirsPart ${oneItem}`

      if [[ "${fileName}_" == "accessPage.html_" ]] ; then
          siteFolder=${dirName}
          sitePage=${fileName}
          title="AccessPage"
          description=""
          inputFile="${oneItem}"
          vis_pageUploadHtmlAndPublish
      elif [[ "${fileName}" != "${fileName%%-access.html}" ]] ; then
          siteFolder=${dirName}
          sitePage=${fileName}
          title="${fileName}"
          description=""
          inputFile="${oneItem}"
          vis_pageUploadHtmlAndPublish
      else
        #opDo echo FILE: ${oneItem} ${fileName} ${fileExtension} ${dirName}
          siteFolder=${dirName}
          sitePage=${fileName}
          title="${fileName}"
          description=""
          inputFile="${oneItem}"
          vis_fileUploadAndPublish
      fi

    elif [[ -d ${oneItem} ]]; then
      #opDo echo DIR: ${oneItem}

        siteFolder=${oneItem}

        title="NOTYET"
        description="NOTYET"

        opDo vis_folderCreateParents

        #
        # Check to see if we have reached a leaf
        #
        typeset subDirs=$( find ${siteFolder} -maxdepth 1 -type d  -print )
        if [ "${subDirs}" = "${siteFolder}" ] ; then
            # So This Is A Leaf
            opDo vis_noPortletsForFolder
            echo "Portlets Touched -- ${siteFolder} -- ${subDirs}"
        else
            echo "Portlets Untouched -- ${siteFolder} -- ${subDirs}"
        fi
        
        opDoExit cd ${oneItem}
    else
      EH_problem "Not a file or directory"
      opDo ls -l ${oneItem}
    fi

  done
}

#===============================================================================
#:mode=shell-script-mode:noTabs=false:tabSize=4:indentSize=4:lineSeparator=\n:
