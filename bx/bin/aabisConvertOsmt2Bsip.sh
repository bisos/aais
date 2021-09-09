#!/bin/bash

IimBriefDescription="NOTYET: Short Description Of The Module"

ORIGIN="
* Revision And Libre-Halaal CopyLeft -- Part Of ByStar -- Best Used With Blee
"

####+BEGIN: bx:bash:top-of-file :vc "cvs" partof: "bystar" :copyleft "halaal+brief"

####+END:

__author__="
* Authors: Mohsen BANAN, http://mohsen.banan.1.byname.net/contact
"


####+BEGIN: bx:bsip:bash:seed-spec :types "seedActions.bash"
SEED="
*  /[dblock]/ /Seed/ :: [[file:/bisos/core/bsip/bin/seedActions.bash]] | 
"
FILE="
*  /This File/ :: /bisos/core/bsip/bin/convertOsmt2Bsip.sh 
"
if [ "${loadFiles}" == "" ] ; then
    /bisos/core/bsip/bin/seedActions.bash -l $0 "$@" 
    exit $?
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

_EOF_
}

_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *Seed Extensions*
_CommentEnd_

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Imports       :: Prefaces (Imports/Libraries) [[elisp:(org-cycle)][| ]]
_CommentEnd_

. ${opBinBase}/opAcctLib.sh
. ${opBinBase}/opDoAtAsLib.sh
. ${opBinBase}/lpParams.libSh
. ${opBinBase}/lpReRunAs.libSh


# PRE parameters

baseDir=""

function G_postParamHook {
     return 0
}


_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  Examples      :: Examples [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_examples {
    typeset extraInfo="-h -v -n showRun"
    #typeset extraInfo=""
    typeset runInfo="-p ri=lsipusr:passive"

    typeset examplesInfo="${extraInfo} ${runInfo}"

    visLibExamplesOutput ${G_myName} 
  cat  << _EOF_
$( examplesSeperatorTopLabel "${G_myName}" )
$( examplesSeperatorChapter "Convert And Update" )
$( examplesSeperatorSection "Current Dir And Below" )
find . -type f -print | egrep '/ftoProc\.sh$' | wc
find . -type f -print | grep -v ${G_myName} | ${G_myName} ${extraInfo} -i miscFix
echo /bisos/panels/bisos-dev/_nodeBase_/fullUsagePanel-en.org | ${G_myName} ${extraInfo} -i miscFix
find . -type f -print | egrep '/ftoProc\.sh$' | ${G_myName} ${extraInfo} -i commonAspects
find . -type f -print | egrep '/ftoProc\.sh$' | bx-dblock -i dblockUpdateFiles
find . -type f -print | egrep '/ftoProc\.sh\.2020[0-9]+$' | wc
$( examplesSeperatorSection "Current Dir" )
${G_myName} ${extraInfo} -i commonAspects *
find . -type f -print | egrep './bss' | ${G_myName} ${extraInfo} -i commonAspects
$( examplesSeperatorSection "Report" )
${G_myName} ${extraInfo} -i report *
find . -type f -print | egrep './bss' | ${G_myName} -i report
find . -type f -print | grep -v ${G_myName} | ${G_myName} -i report
${G_myName} -i report *
$( examplesSeperatorSection "Cleanup" )
find . -type f -print |  egrep '\.2020[0-9]+$' 
find . -type f -print |  egrep '\.2020[0-9]+$' | xargs /bin/rm
_EOF_
}

noArgsHook() {
  vis_examples
}

_CommentBegin_
*  [[elisp:(org-cycle)][| ]]  IIFs          :: Interactively Invokable Functions (IIF)s |  [[elisp:(org-cycle)][| ]]
_CommentEnd_


function vis_report {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Function description.
Design Pattern: processEach based on args or stdin.
Examples:
      ${G_myName} -i userAcctsReport bisos
      echo bisos bystar | ${G_myName} -i userAcctsReport
_EOF_
    }
    local thisFunc=${G_thisFunc}

    function processEach {
        EH_assert [[ $# -eq 1 ]]
        local each="$1"

        if [ "${G_myName}" == "${each}" ] ; then
            ANT_raw "This ${G_myName} File -- Skipped."
            lpReturn
        fi

        echo "Processing ${thisFunc}:: ${each}"

        # lpDo egrep "^ *opDoRet bystarAcctAnalyze \${bxoId}" ${each}
        lpDo egrep "opDoRet bystarAcctAnalyze" ${each}
        lpDo egrep "bxoIdCentralPrep" ${each}

        lpReturn 0
    }

####+BEGIN: bx:bsip:bash/processArgsAndStdin 
     function processArgsAndStdin {
        local effectiveArgs=( "$@" )
        local stdinArgs
        local each
        if [ ! -t 0 ]; then # FD 0 is not opened on a terminal, there is a pipe
            readarray stdinArgs < /dev/stdin
            effectiveArgs=( "$@" "${stdinArgs[@]}" )
        fi
        if [ ${#effectiveArgs[@]} -eq 0 ] ; then
            ANT_raw "No Args And Stdin Is Empty"
            lpReturn
        fi
        for each in "${effectiveArgs[@]}"; do
            lpDo processEach "${each%$'\n'}"
        done
    }
    lpDo processArgsAndStdin "$@"
####+END:
    
    lpReturn
}


function vis_commonAspects {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Function description.
Design Pattern: processEach based on args or stdin.
Examples:
      ${G_myName} -i userAcctsReport bisos
      echo bisos bystar | ${G_myName} -i userAcctsReport
_EOF_
    }
    local thisFunc=${G_thisFunc}

    function processEach {
        EH_assert [[ $# -eq 1 ]]
        local each="$1"
        local eachDateTag="${dateTag}"

        if [ "${G_myName}" == "${each}" ] ; then
            ANT_raw "This ${G_myName} File -- Skipped."
            lpReturn
        fi

        #echo "${thisFunc}" "${each}"   
        lpDo FN_fileSafeCopy "${each}" "${each}.${eachDateTag}"

        lpDo FN_lineRemoveFromFile "opDoRet bystarAcctAnalyze" "${each}.${eachDateTag}"

        cat ${each}.${eachDateTag} | \
            sed -e "s@\#\!/bin/osmtKsh@#!/bin/bash@g" \
                -e "s@bxoIdCentralPrep@bxoIdPrep@g"  > ${each}
        
        lpReturn 0
    }

####+BEGIN: bx:bsip:bash/processArgsAndStdin 
     function processArgsAndStdin {
        local effectiveArgs=( "$@" )
        local stdinArgs
        local each
        if [ ! -t 0 ]; then # FD 0 is not opened on a terminal, there is a pipe
            readarray stdinArgs < /dev/stdin
            effectiveArgs=( "$@" "${stdinArgs[@]}" )
        fi
        if [ ${#effectiveArgs[@]} -eq 0 ] ; then
            ANT_raw "No Args And Stdin Is Empty"
            lpReturn
        fi
        for each in "${effectiveArgs[@]}"; do
            lpDo processEach "${each%$'\n'}"
        done
    }
    lpDo processArgsAndStdin "$@"
####+END:
    
    lpReturn
}


function vis_miscFix {
    G_funcEntry
    function describeF {  G_funcEntryShow; cat  << _EOF_
Function description.
Design Pattern: processEach based on args or stdin.
Examples:
      ${G_myName} -i userAcctsReport bisos
      echo bisos bystar | ${G_myName} -i userAcctsReport
_EOF_
    }
    local thisFunc=${G_thisFunc}

    function processEach {
        EH_assert [[ $# -eq 1 ]]
        local each="$1"
        local eachDateTag="${dateTag}"

        #echo "${thisFunc}" "${each}"   
        lpDo FN_fileSafeCopy "${each}" "${each}.${eachDateTag}"

        cat ${each}.${eachDateTag} | \
            sed -e "s@subBxe@bxeTree@g" > ${each}
        
        lpReturn 0
    }

####+BEGIN: bx:bsip:bash/processArgsAndStdin 
     function processArgsAndStdin {
        local effectiveArgs=( "$@" )
        local stdinArgs
        local each
        if [ ! -t 0 ]; then # FD 0 is not opened on a terminal, there is a pipe
            readarray stdinArgs < /dev/stdin
            effectiveArgs=( "$@" "${stdinArgs[@]}" )
        fi
        if [ ${#effectiveArgs[@]} -eq 0 ] ; then
            ANT_raw "No Args And Stdin Is Empty"
            lpReturn
        fi
        for each in "${effectiveArgs[@]}"; do
            lpDo processEach "${each%$'\n'}"
        done
    }
    lpDo processArgsAndStdin "$@"
####+END:
    
    lpReturn
}


_CommentBegin_
*  [[elisp:(beginning-of-buffer)][Top]] ################ [[elisp:(delete-other-windows)][(1)]]  *End Of Editable Text*
_CommentEnd_

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
