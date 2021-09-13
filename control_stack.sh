#!/bin/sh
PREFIX_NAME=
SYSTEM_NAME=
SUFFIX_NAME=

S3_BUCKET_NAME=
LOCAL_TEMPLATE_PATH=

ROOT_TEMPLATE_NAME=
NETWORK_TEMPLATE_NAME=
SECURITY_TEMPLATE_NAME=
ALB_TEMPLATE_NAME=
ECS_TEMPLATE_NAME=
RDS_TEMPLATE_NAME=
LAMBDA_TEMPLATE_NAME=


# SECURITY_TEMPLATE_YML=./security/security.yml
# WEB_TEMPLATE_YML=./web/web.yml


function usage {
  cat <<EOM
Usage: $(basename "$0") [OPTION]...
  -h          Display help
  -c          create-stack
  -d          delete-stack
  -u          update-stack
EOM

  exit 2
}




while getopts cdu optKey; do
  case "$optKey" in
    c)
      aws s3 cp $LOCAL_TEMPLATE_PATH/$NETWORK_TEMPLATE_NAME     $S3_BUCKET_NAM/$NETWORK_TEMPLATE_NAME
      aws s3 cp $LOCAL_TEMPLATE_PATH/$SECURITY_TEMPLATE_NAME    $S3_BUCKET_NAM/$SECURITY_TEMPLATE_NAME
      aws s3 cp $LOCAL_TEMPLATE_PATH/$ALB_TEMPLATE_NAME         $S3_BUCKET_NAM/$ALB_TEMPLATE_NAME
      aws s3 cp $LOCAL_TEMPLATE_PATH/$ECS_TEMPLATE_NAME         $S3_BUCKET_NAM/$ECS_TEMPLATE_NAME
      aws s3 cp $LOCAL_TEMPLATE_PATH/$LAMBDA_TEMPLATE_NAME      $S3_BUCKET_NAM/$LAMBDA_TEMPLATE_NAME
      
      aws cloudformation deploy --template-file $ROOT_TEMPLATE_FILE --stack-name $PREFIX_NAME-$SYSTEM_NAME-$SUFFIX_NAME --capabilities CAPABILITY_NAMED_IAM --parameter-overrides `cat exec_parameters.properties`
      ;;
    d)
    #   delete_stack
      ;;
    u)
    #   update_stack
      ;;
    '-h'|'--help'|* )
      usage
      ;;
  esac
done