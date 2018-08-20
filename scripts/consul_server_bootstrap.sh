#!/bin/bash -ex
# Hashicorp Consul Bootstrapping
# authors: tonynv@amazon.com, bchav@amazon.com, sancard@amazon.com
# date:  May,10,2017
# NOTE: This requires GNU getopt.  On Mac OS X and FreeBSD you much install GNU getopt



# Configuration
PROGRAM='HashiCorp Consul Server'
CONSULVERSION='1.2.2'
CONSUL_TEMPLATE_VERSION='0.19.5'


##################################### Functions
function checkos () {
platform='unknown'
unamestr=`uname`
if [[ "$unamestr" == 'Linux' ]]; then
   platform='linux'
else
   echo "[WARINING] This script is not supported on MacOS or freebsd"
   exit 1
fi
}

function usage () {
echo "$0 <usage>"
echo " "
echo "options:"
echo -e  "-h, --help \t show options for this script"
echo -e "--consul_expect \t Number of Consul nodes to expect"
echo -e "--consul_tag_key \t tag key to use for joining"
echo -e "--consul_tag_value \t tag value to use for joining"
echo -e "--s3bucket \t specify -s3bucket (your-bucket)"
echo -e "--s3prefix \t specify -s3prefix (prefix/to/key/ | folder/folder/file/)"
}

function chkstatus () {
if [ $? -eq 0 ]
then
  echo "Script [PASS]"
else
  echo "Script [FAILED]" >&2
  exit 1
fi
}
##################################### Functions

# Call checkos to ensure platform is Linux
checkos

## set an initial value
CONSUL_EXPECT=3
CONSUL_TAG_KEY='NONE'
CONSUL_TAG_VALUE='NONE'
S3BUCKET='NONE'
S3URL='NONE'
S3PREFIX='NONE'

# Read the options from cli input
TEMP=`getopt -o h:  --long help,verbose,consul_expect:,consul_tag_key:,consul_tag_value:,s3bucket:,s3prefix: -n $0 -- "$@"`
eval set -- "$TEMP"

if [ $# == 1 ] ; then echo "No input provided! type ($0 --help) to see usage help" >&2 ; exit 1 ; fi

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
    --consul_expect )
  if [ "$2" -eq "$2" ] 2>/dev/null
  then
    CONSUL_EXPECT="$2";
    shift 2
  else
    echo "[ERROR]: vaule of consul_expect must be an [int] "
    exit 1
  fi
  ;;
    --consul_tag_key )
  CONSUL_TAG_KEY="$2";
  shift 2
  ;;
  --consul_tag_value )
  CONSUL_TAG_VALUE="$2";
  shift 2
  ;;
    --s3bucket )
  S3BUCKET="$2";
  shift 2
  ;;
    --s3prefix )
  S3PREFIX="${2%/}";
  shift 2
  ;;
    -- )
  break;;
    *) break ;;
  esac
done

if [[ ${VERBOSE} == 'true' ]]; then
  echo "consul_expect = $CONSUL_EXPECT"
  echo "consul_tag_key = $CONSUL_TAG_KEY"
  echo "consul_tag_value = $CONSUL_TAG_VALUE"
  echo "s3bucket = $S3BUCKET"
  echo "s3prefix = $S3PREFIX"
fi

# Strip leading slash
if [[ $S3PREFIX == /* ]];then
      echo "Removing leading slash"
      #echo $S3PREFIX | sed -e 's/^\///'
      S3PREFIX=$(echo $S3PREFIX | sed -e 's/^\///')
fi

# Format S3 script path
S3SCRIPT_PATH="https://${S3BUCKET}.s3.amazonaws.com/${S3PREFIX}/scripts"
echo "S3SCRIPT_PATH = ${S3SCRIPT_PATH}"

# SCRIPT VARIBLES
BINDIR='/usr/bin'
CONSULDIR='/opt/consul'
CONFIGDIR="${CONSULDIR}/config"
DATADIR="${CONSULDIR}/data"
CONSULCONFIGDIR='/etc/consul'
CONSULDOWNLOAD="https://releases.hashicorp.com/consul/${CONSULVERSION}/consul_${CONSULVERSION}_linux_amd64.zip"
CONSUL_TEMPLATE_DOWNLOAD="https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip"
CONSUL_SERVICE_CONF="${S3SCRIPT_PATH}/consul.service"
CONSUL_SERVICE_FILE="/etc/systemd/system/consul.service"

echo "Updating package list..."
apt-get -y update
chkstatus

echo "Installing dependencies..."
apt-get -y install curl unzip
chkstatus

echo "Creating Consul Directories..."
mkdir -p $CONSULCONFIGDIR
mkdir -p $CONSULDIR
mkdir -p $CONFIGDIR
mkdir -p $DATADIR
chmod 755 $CONSULCONFIGDIR
chmod 755 $CONSULDIR
chmod 755 $CONFIGDIR
chmod 755 $DATADIR

echo "Installing Consul Template..."
curl -L $CONSUL_TEMPLATE_DOWNLOAD > /tmp/consul_template.zip
unzip  /tmp/consul_template.zip -d ${BINDIR}/
chmod 0755 ${BINDIR}/consul-template
chown root:root ${BINDIR}/consul-template
chkstatus

echo "Installing Consul..."
curl -L $CONSULDOWNLOAD > /tmp/consul.zip
unzip  /tmp/consul.zip -d ${BINDIR}/
chmod 0755 ${BINDIR}/consul
chown root:root ${BINDIR}/consul
chkstatus

echo "Installing Consul startup scripts..."
curl $CONSUL_SERVICE_CONF > ${CONSUL_SERVICE_FILE}
chmod 755 ${CONSUL_SERVICE_FILE}

curl  -s ${S3SCRIPT_PATH}/consul_server_config.stub > ${CONSULCONFIGDIR}/server.json.tmp
sed -i "s/__BOOTSTRAP_EXPECT__/${CONSUL_EXPECT}/" ${CONSULCONFIGDIR}/server.json.tmp
sed -i "s/__CONSUL_TAG_KEY__/${CONSUL_TAG_KEY}/" ${CONSULCONFIGDIR}/server.json.tmp
sed -i "s/__CONSUL_TAG_VALUE__/${CONSUL_TAG_VALUE}/" ${CONSULCONFIGDIR}/server.json.tmp
mv ${CONSULCONFIGDIR}/server.json.tmp ${CONSULCONFIGDIR}/server.json

echo "Starting Consul..."
service consul start
chkstatus

echo "Installing Dnsmasq..."
apt-get -qq -y install dnsmasq-base dnsmasq

echo "Configuring Dnsmasq..."
sh -c 'echo "server=/consul/127.0.0.1#8600" >> /etc/dnsmasq.d/consul'
sh -c 'echo "listen-address=127.0.0.1" >> /etc/dnsmasq.d/consul'
sh -c 'echo "bind-interfaces" >> /etc/dnsmasq.d/consul'

echo "Restarting dnsmasq..."
service dnsmasq restart
chkstatus
