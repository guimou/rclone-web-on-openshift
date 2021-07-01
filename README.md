# Rclone Web UI on OpenShift

This is a simple implementation of the [Rclone](https://rclone.org/) tool in OpenShift. It allows you to use its Web interface to browse content of endpoints, transfer files,...
Main goal was to provide an easy to use interface to work with S3 storage provided by OpenShift Data Foundation or Rook-Ceph. Of course it can be used will endpoints provided by Rclone.

## Deployment

Create a project/namespace for your installation.

From the `deploy` folder, apply the different YAML files:

* `pvc.yaml`: creates a persistent volume to hold the configuration
* `deploymentconfig.yaml`: creates the deployment. Modify admin account and password if you want to restrict access. You should!
* `service.yaml`, `route.yaml`: create the external access so that you can connect to the Web UI.

## Usage

* Log in
* Create configuration for you endpoints
* In the case of ODF/OCS/Rook/Ceph S3 deployed on OpenShift, just enter
  * AWS Access Key ID
  * AWS Secret Access Key
  * Endpoint for the S3 Service (internal DNS). For example, for ODF with the RGW, this should be `http://rook-ceph-rgw-ocs-storagecluster-cephobjectstore.openshift-storage.svc:80)`
* You can now use this endpoint in the Explorer view.

[Full documentation](https://rclone.org/gui/)

## Source

In the `source` folder you'll find the simple Dockerfile used to create the container image.
