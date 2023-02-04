# Rclone Web UI on OpenShift

This is a simple implementation of [Rclone](https://rclone.org/) on OpenShift. It allows you to use its Web interface to easily browse content of endpoints, transfer files,...
The main goal is to provide an easy to use interface to transfer data to/from your environments, from multiple types of endpoints, like S3 Storage or shared file system. It a fast and efficient way to transfer data to/from your data science environment.

Two different images and deployment methods are available:

- One to be used in Open Data Hub or Red Hat OpenShift Data Science in a Data Science Project.
- One for a standalone deployment on any OpenShift environment. Of course this can also be installed alongside ODH or RHODS, but in this case it won't be integrated inside Data Science Projects. However, a configuration is provided to create a tile on the dashboard to give an easy access to the environment.

## Deployment in Open Data Hub or OpenShift Data Science

- In the Cluster Settings menu, import the image ``. You can name it Rclone.
- In your DSP project, create a new workbench using the Rclone image. You can set the storage size as minimal as it's only there to store the configuration of the endpoints.
- Launch Rclone from the link once it's deployed!

TIP: Because the minimal size allowed by the dashboard for a storage volume is currently 1GB, you can also create a PVC manually in the namespace corresponding to your Data Science Project, for example 100MB or less, and select this volume when creating the workbench.

## Standalone Deployment

- Create a project/namespace for your installation.
- From the `deploy` folder, apply the different YAML files:
  - `pvc.yaml`: creates a persistent volume to hold the configuration
  - `deployment.yaml`: creates the deployment. Modify admin account and password if you want to restrict access. **You should!**
  - `service.yaml`, `route.yaml`: create the external access so that you can connect to the Web UI.
  - **Optionally**, to create a tile on the ODH/RHODS dashboard:
    - modify the `tile.yaml` file with the address of the Route that was created previously.
    - the will appear under the available applications in the dashboard. Select it and click on "Enable" to make it appear in the "Enabled" menu.

## Usage

- Log in
- Create a configuration for your endpoint
- In the case of ODF or Rook-Ceph S3 deployed on OpenShift, just enter
  - AWS Access Key ID
  - AWS Secret Access Key
  - Endpoint for the S3 Service (internal DNS). Examples:
    - For ODF with the MCG, this should be `http://s3.openshift-storage.svc:80)`
    - For ODF with the RGW, this should be `http://rook-ceph-rgw-ocs-storagecluster-cephobjectstore.openshift-storage.svc:80)`
- You can now use this endpoint in the Explorer view.

[Full documentation](https://rclone.org/gui/)

## Source

In the `src` folder you'll find the different Dockerfiles used to create the container images.
