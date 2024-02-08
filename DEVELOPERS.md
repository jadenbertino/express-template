# Developer Guide

This document outlines the Continuous Integration/Continuous Deployment (CI/CD) process for our project. It is intended to provide developers with clear instructions on the workflow to follow for developing, testing, and deploying code.

## CI/CD Workflow

Our CI/CD process is structured to ensure consistent code quality, successful builds, and proper deployments. Please adhere to the following steps:

### 1. Open a New Branch

For each new feature or bug fix, create a new branch from the main branch. This ensures that the main branch always contains stable and deployable code.

### 2. Make Changes and Commit

Implement your code changes in the new branch. Commit your changes regularly with meaningful commit messages. 

During development, run the API locally without a docker image.

You can do this with the command: `npm run dev`

### 3. Build the Project

Once you are satisfied with your changes, build the project to ensure that it compiles successfully without errors.

- Update the version in `package.json`
- Update the `CHANGELOG.md` with the new version and a brief description of the changes
- Build a new docker image with: `npm run build`

### 4. Local Testing with Staging Environment

Now it is time to test your changes locally against the staging API to catch any potential issues early.

Start the container in the staging environment with: `ENVIRONMENT=staging npm run test`

Use Postman or a similar tool to test the local staging API.

### 5. Deploy to Staging and Test

After successful local testing, deploy your changes to the staging environment.

This step is crucial for testing in an environment that closely resembles production.

Run the command `ENVIRONMENT=staging npm run deploy`

Once deployment completes, test the deployed staging API with Postman to ensure functionality.

### 6. Local Testing with Production Environment

Start the container in the production environment to test your changes locally.

Run the command `ENVIRONMENT=production npm run test`

Use Postman to test the local production API.

### 7. Deploy to Production and Test

Finally, deploy your changes to the production environment.

Run the command `ENVIRONMENT=production npm run deploy`

Test the deployed production API with Postman to verify that everything works as expected.

## Conclusion

Adhering to this CI/CD process is crucial for maintaining the integrity and stability of our codebase. It ensures that all features and fixes are thoroughly tested before they reach production, thereby minimizing disruptions and maintaining high-quality standards.