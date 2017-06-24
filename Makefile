#
# Push templates to S3
#

ifeq ($(BUCKET_NAME),)
	BUCKET_NAME?=cfn-andyspohn-com
endif

ifeq ($(TEMPLATE_NAME),)
	TEMPLATE_NAME?=quickstart-linux-bastion-dev
endif

all: push validate
.PHONY: all

push:
	@echo "pushing templates to S3"
	@aws s3 sync . s3://$(BUCKET_NAME)/$(TEMPLATE_NAME) \
		--delete \
		--only-show-errors \
		--exclude "*" --include "scripts/*" --include "submodules/*" --include "templates/*" \
		--acl public-read

test: validate
	@open "https://console.aws.amazon.com/cloudformation/home?region=us-east-2#/stacks/new?stackName=ha-bastion&templateURL=https://s3.amazonaws.com/cfn-andyspohn-com/quickstart-linux-bastion-dev/templates/linux-bastion.template"

validate: push
	@aws cloudformation \
		validate-template \
		--template-url https://s3.amazonaws.com/$(BUCKET_NAME)/$(TEMPLATE_NAME)/templates/linux-bastion.template