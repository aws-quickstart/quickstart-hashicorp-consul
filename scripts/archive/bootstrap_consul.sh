#!/bin/bash -e
# Hashicorp Consul Bootstraping 
# authors: tonynv@amazon.com, bchav@amazon.com
# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD you much install GNU getopt

# PARSER ARGUMENTS
PROGRAM='HashiCorp Consul'

function usage () {
echo "$0 <usage>"
echo " "
echo "options:"
echo -e  "-h, --help \t show options for this script"
echo -e "--consul \t Number of Consul nodes to expect -C(3)"
echo -e "--s3url \t specify the s3 URL  -S3url (https://s3.amazonaws.com/)"
echo -e "--s3bucket \t specify -s3bucket (your-bucket)"
echo -e "--s3prefix \t specify -s3prefix (prefix/to/key | folder/folder/file)"
}

# set an initial value
CONSUL=3

# read the options
TEMP=`getopt -o hv:  --long help,verbose,consul:,s3bucket:,s3url:,s3prefix: -n $0 -- "$@"`
eval set -- "$TEMP"

if [ $# -lt 2 ] ; then echo "No input provided! type ($0 --help) to see usage help" >&2 ; exit 1 ; fi

# extract options and their arguments into variables.
while true; do
  case "$1" in
    -h | --help)
        usage
        exit 1
        ;;
    -v | --verbose )
        echo "[] DEBUG = ON"
        VERBOSE=true;
        shift
        ;;
    --consul )
        CONSUL="$2";
        shift 2
        ;;
    --s3url )
        S3URL="$2";
        shift 2
        ;;
    --s3bucket )
        S3BUCKET="$2";
        shift 2
        ;;
    --s3prefix )
        S3PREFIX="$2";
        shift 2
        ;;
    -- )
        break;;
    *) break ;;
  esac
done

#if [ -z ${S3BUCKET} ]|| [ -z ${S3URL} ]|| [ -z ${S3PREFIX} ]; then
#		if [[ ${VERBOSE} == 'true' ]]; then
#        echo "s3bucket = $S3BUCKET"
#        echo "S3url = $S3URL"
#        echo "s3prefix = $S3PREFIX"
#		fi
#        echo "[ERROR] (--S3url --s3bucket --s3prefix) need to specified "  
#        echo "Script Terminating...."
#        exit 1;
#fi

# do something with the variables -- in this case the lamest possible one :-)
if [[ ${VERBOSE} == 'true' ]]; then
echo "consul = $CONSUL"
echo "s3bucket = $S3BUCKET"
echo "S3url = $S3URL"
echo "s3prefix = $S3PREFIX"
fi

