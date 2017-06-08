#
# Push templates to S3
#

ifeq ($(BUCKET_NAME),)
	BUCKET_NAME?=cfn-andyspohn-com
endif

push:
	@echo "pushing templates to S3"
	@aws s3 sync    scripts/ s3://$(BUCKET_NAME)/quickstart-linux-bastion/scripts    --exclude */.git --acl public-read
	@aws s3 sync submodules/ s3://$(BUCKET_NAME)/quickstart-linux-bastion/submodules --exclude */.git --acl public-read
	@aws s3 sync  templates/ s3://$(BUCKET_NAME)/quickstart-linux-bastion/templates  --exclude */.git --acl public-read
