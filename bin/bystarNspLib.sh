
# The following variables are set

bystarNsp_name=""

bystarNsp_filesList="
  bynameSubscriberProfiles.nsp
  generalFeatures.nsp 
  ploneFeatures.nsp
  galleryFeatures.nsp
  mailAddrItems.nsp
"
#   saUID.nsp



function bystarNsp_sourceAll {
  #set -x
  #$1 - nspBaseDir
  
  if  test $# -ne 1 ; then
    EH_problem "$0 requires one args: Args=$*"
    return 1
  fi 

  nspBaseDir=$1

  EH_assert [[ -d ${nspBaseDir} ]]

  opDoComplain cd ${nspBaseDir} || return

  typeset thisFile=""
  for thisFile in ${bystarNsp_filesList} ; do
    if [[ -f ${thisFile} ]] ; then
      . ${thisFile}
    else
      EH_problem "${thisFile} -- Missing in ${nspBaseDir}"
    fi
  done

  item_bap_full
  item_sa_SubscriberProfiles
  item_gallery_full

#   echo zz ${iv_subsFirstName}
#   echo $iv_bap_owner_acctType

#   echo iv_bap_owner_number=${iv_bap_owner_number}

#   echo iv_gallery_owner=${iv_gallery_owner}

  # Walkin through the NSP files and load them

}


function bystarNsp_infoGet {
  #$1 - nspBaseDir
  
  if  test $# -ne 1 ; then
    EH_problem "$0 requires one args: Args=$*"
    return 1
  fi 

  nspBaseDir=$1

  bystarNsp_sourceAll ${nspBaseDir}

  # Load them all first, then derive any additional
  # variables.

}

