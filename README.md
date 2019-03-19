# README

### Setup Instructions
This following steps are instructions to launch and view a simple Ruby on Rails application that authenticates with Procore's API using the OAuth 2.0 Authorization Code Grant Type flow. The application is configured to access either Procore's production environment or Procore's developer sandbox environment.

THIS REPOSITORY IS FOR TRAINING PURPOSES ONLY.

1. Clone this repository
2. Run `bundle install`
3. Run `bundle exec figaro install`
4. Installing the figaro gem will create an untracked file: `config/application.yml`

Within this file, configure your application's Client ID, Client Secret, and Redirect URI in order to save these as the application's environment variables:

        * CLIENT_ID: ''
        * CLIENT_SECRET: ''
        * REDIRECT_URI: 'http://localhost:3000/login/callback'
        * OAUTH_URL: ''
        * BASE_URL: ''

    * Client ID and Client Secret values are provided when [creating an application](https://developers.procore.com/documentation/new-application) in the Procore Developer Portal. The redirect URI above should be added to your application, which can be done on your application's home page.
    * The BASE_URL and the OAUTH_URL will depend on which environment you're working accessing. If you're working in the production environment, the OAUTH_URL will be https://login.procore.com and the BASE_URL will be https://api.procore.com. For the sandbox environment, both the OAUTH_URL and the BASE_URL should be set to https://sandbox.procore.com.
    * After these values have been configured within the `application.yml` file, make sure to save your changes.

5. Navigate to the directory where the repository was cloned to and [launch your Rails server](https://guides.rubyonrails.org/command_line.html#rails-server).
6. The landing page will include a button that says, "Sign In to Procore". Click this button and enter your Procore email address/password.
7. After authenticating with Procore, you will be redirected back to the sample application. This page will include a table containing the first and last five characters of both your access token and your refresh token. In addition, there will be timestamps corresponding to when the access token was generated and when it expires (2 hours after generation).
8. To access the data returned by the [Show User Info](https://developers.procore.com/reference/me) endpoint, click on the "Show User Information" button on the home page. 
9. To refresh your access token, click on the "Refresh Access Token" button. Notice that the corresponding values will be updated in the table on the home page.

If you have any questions regarding this application's code or functionality, please reach out to apisupport@procore.com.
