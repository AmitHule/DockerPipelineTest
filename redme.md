# Concourse pipeline for Android

## General information

There are two pipelines on Concourse for building our iOS app:

* `thinkservice-android-app-qs`
* `thinkservice-android-app-prod`

Each pipeline is building and pushing the app for their corresponding stage, whereas  `thinkservice-android-app-qs` is fetching the source code from branch `develop` and `thinkservice-android-app-prod` is building from the `master` branch.

Fot both pipelines in order to update them you have to create a `credentials.yml` file in folder `mechanic/ci` which specifies the following values:

```yaml
githubUsername:
githubPassword:
hockyAppToken:
hockeyAppTokenProd:
apkFileName:
keyStorePass:
keyStore:
```

This file is included in the `.gitignore` file and should not be pushed to remote.

## Updating a pipeline

In order to update a pipeline you need to use the following commands:

### Login to concourse

`fly --target <Target Name> login --team-name thinkservice --concourse-url https://ci.sys.emea.vwapps.io`

### Update a pipeline

`fly -t ci set-pipeline --config <your-config.yml> --pipeline <your pipeline> --load-vars-from credentials.yml`
fly -t <Target Name> set-pipeline <your pipeline.yml for prod or qs> --pipeline <pipeline name> --load-vars-from credentials.yml

## Additional information

For android project to build we need docker image which can build android application therefore the image `runmymind/docker-android-sdk` is used in run-built-android-app.yml.
And to upload generated signed apk on hockyapp, keystore file (.jks) is required. That file contents are placed in `credentials.yml` as a key `keyStore`.
*Important*: `keyStore` value is the content of .jks file converted into base64.

## Concourse task outputs and inputs

If you define outputs for a Concourse task and try to copy the respective files into the output folder **it is not possible** to run the `cp` command inside an exernal shell script (`.sh`).
Instead do the following (exemplary):
```sh
-- Start snippet --
outputs:
 - name: built-android-app

 run:
  dir: android-repo
  path: Mechanic/ci/scripts/run-build-android-app.sh
  args:
      - false
-- End snippet --
```

*Explanation:* By running the `cp` command like in the example at the top, Concourse doesn't execute at `volume` level but at `container` level. When executing at `volume` level (from within the `.sh` file), Concourse can't find the specified `outputs` folder to copy the artifact into and the result therefore can't be used in the next task.
