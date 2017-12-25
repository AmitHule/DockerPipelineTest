Concourse pipeline for iOS
General information

There are two pipelines on Concourse for building our iOS app:

thinkservice-ios-app-qs
thinkservice-ios-app-prod

Each pipeline is building and pushing the app for their corresponding stage, whereas thinkservice-ios-app-qs is fetching the source code from branch develop and thinkservice-ios-app-prod is building from the master branch.

Fot both pipelines in order to update them you have to create a credentials.yml file in folder mechanic/ci which specifies the following values:

githubUsername: 
githubPassword: 
hockeyAppTokenQS:
hockeyAppTokenProd:

This file is included in the .gitignore file and should not be pushed to remote.
Updating a pipeline

In order to update a pipeline you need to use the following commands:
Login to concourse

fly -t ci login --concourse-url https://ci.sys.emea.vwapps.io -n thinkservice
Update a pipeline

fly -t ci set-pipeline --config <your-config.yml> --pipeline <your pipeline> --load-vars-from credentials.yml
Additional information

For iOS builds we are using a local concourse worker. For provisioning we are using the VWG_Generic profile. The profile file must be installed and present in the folder /var/root/Library/MobileDevice/Provisioning Profiles/.

To start the worker run the script concourse_worker.sh inside the folder Users/buildmachine/concourse_worker.

Important: Run the script as root (sudo ./concours_worker.sh), as Concourse needs to do operations that require root access.
Concourse task outputs and inputs

If you define outputs for a Concourse task and try to copy the respective files into the output folder it is not possible to run the cp command inside an exernal shell script (.sh). Instead do the following (exemplary):

-- Start snippet --
outputs:
- name: built-ios-app

run:
path: sh
args:
- -exc
- |
./ios-repo/mechanic/ci/tasks/run-build-ios-app.sh
cp -v ios-repo/mechanic/build/*.ipa built-ios-app/
-- End snippet --

Explanation: By running the cp command like in the example at the top, Concourse doesn't execute at volume level but at container level. When executing at volume level (from within the .sh file), Concourse can't find the specified outputs folder to copy the artifact into and the result therefore can't be used in the next task.
