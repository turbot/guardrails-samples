# AWS > SSM > Stack
resource "turbot_policy_setting" "aws_ssm_stack" {
  resource = turbot_policy_pack.main.id
  type     = "tmod:@turbot/aws-ssm#/policy/types/ssmStack"
  value    = "Check: Configured"
  # value    = "Enforce: Configured"
}

# AWS > SSM > Stack > Source
resource "turbot_policy_setting" "ssm_stack_source" {
  resource = var.region_resource
  type     = "tmod:@turbot/aws-ssm#/policy/types/ssmStackSource"
  value    = <<EOP
    # Creates a SSM Command Document which installs package on Linux Instance from OS package source repository
    resource "aws_ssm_document" "turbot_linux_package_installer_public_network_document" {
      name            = "Turbot-LinuxPackageInstaller-PublicNetwork"
      document_type   = "Command"
      document_format = "YAML"
      content         = <<EOC
        schemaVersion: "2.2"
        description: Installs package on Linux Instance from OS package source repository
        parameters:
          package:
            type: String
            description: (Required) The package to be installed
            minChars: 1
        mainSteps:
          - action: "aws:runShellScript"
            name: InstallPackage
            inputs:
              runCommand:
                - |
                  #!/bin/bash
                  set -e

                  OS="$(hostnamectl | sed -n -e 's/^.*Operating System: //p')"
                  echo "OS is: $OS"

                  if [[ $OS =~ "Ubuntu" ]]; then
                    apt-get update
                    apt-get install -y {{ package }}
                  fi
    EOC
    }

    # Creates a SSM Command Document which installs packages avaiable on S3 buckets.
    # The document created here is intended to be called by Turbot-LinuxPackageInstaller-PrivateNetwork document
    resource "aws_ssm_document" "turbot_linux_s3_package_installer_document" {
      name            = "Turbot-LinuxS3PackageInstaller"
      document_type   = "Command"
      document_format = "YAML"
      content         = <<EOC
        schemaVersion: "2.2"
        description: Install packages avaiable on S3 buckets. This document is part of Turbot-LinuxPackageInstaller-PrivateNetwork document
        parameters:
          packageS3Url:
            type: String
            description: (Required) The S3 package URL to be installed
            minChars: 1
        mainSteps:
          - action: aws:downloadContent
            name: DownloadPackageFromS3
            inputs:
              sourceType: S3
              sourceInfo: >-
                {"path": "{{ packageS3Url }}"}
          - action: aws:runShellScript
            name: InstallPackage
            inputs:
              runCommand:
                - |
                  #!/bin/bash
                  set -e

                  OS="$(hostnamectl | sed -n -e 's/^.*Operating System: //p')"
                  echo "OS is: $OS"

                  packageS3Url="{{ packageS3Url }}"
                  packageFile=$(echo $packageS3Url | rev | cut -d'/' -f 1 | rev)
                  ls -la $packageFile
                  pwd

                  if [[ $OS =~ "Ubuntu" ]]; then
                    dpkg -i $packageFile
                  fi
    EOC
    }

    # Creates a SSM Automation Document which installs package on Linux Instance inside a private network by storing target package on a S3 bucket
    resource "aws_ssm_document" "turbot_linux_package_installer_private_network_document" {
      name            = "Turbot-LinuxPackageInstaller-PrivateNetwork"
      document_type   = "Automation"
      document_format = "YAML"
      content         = <<EOC
        schemaVersion: "0.3"
        description: Installs package on Linux Instance inside a private network by storing target package on a S3 bucket
        parameters:
          packageUrl:
            type: String
            description: (Required) The URL of the package to be installed
            minChars: 1
          bucket:
            type: String
            description: (Required) The bucket where the package will be stored
            minChars: 1
        assumeRole: "${var.ssm_document_role}"
        mainSteps:
          # This script execution runs on Systems Manager sandbox, charges may apply
          - name: DownloadPackageToS3
            action: "aws:executeScript"
            inputs:
              Runtime: python3.7
              Handler: script_handler
              InputPayload:
                packageUrl: "{{ packageUrl }}"
                bucket: "{{ bucket }}"
              Script: |-
                def script_handler(events, context):
                  import urllib3
                  import boto3

                  package_url = events["packageUrl"]
                  bucket = events["bucket"]
                  object_key = package_url.split("/")[-1]

                  print("Pulling package: %s" % package_url)
                  http = urllib3.PoolManager()
                  r = http.request("GET", package_url, preload_content=False)
                  s3 = boto3.client("s3")

                  s3.upload_fileobj(r, bucket, object_key)
                  package_s3_url = "https://%s.s3.amazonaws.com/%s" % (bucket, object_key)
                  return {"packageS3Url": package_s3_url}
            outputs:
              - Name: packageS3Url
                Selector: $.Payload.packageS3Url
                Type: String
          - name: ExecuteTurbotLinuxS3PackageInstallerDocument
            action: "aws:runCommand"
            inputs:
              DocumentName: Turbot-LinuxS3PackageInstaller
              Parameters:
                packageS3Url: "{{DownloadPackageToS3.packageS3Url}}"
              Targets:
                - Key: tag:turbot:InventoryCollection
                  Values:
                    - "true"
    EOC
    }
EOP
}
