# Oauth2 proxy

This folder holds deployment for the OAuth2 proxy.
It uses Azure for authentication so your application doesn't have to deal with it.

## Prerequisites

To deploy this, you will need Ansible and Certbot with your owned domain.

### Tools
```
# install ansible
pip3 install --include-deps ansible

# install certbot
sudo snap install --classic certbot
```

### Certificate
After you install the needed tools, you will need to set-up the certificates.

```
# Run this command for manual add
sudo certbot certonly --manual -d "*.<domain>" --preferred-challenges dns

# Add generated txt to DNS with _acme-challenge

# check if it is there
dig _acme-challenge.<domain> -t txt

# Certificates are stored here:
# /etc/letsencrypt/live/<domain>/fullchain.pem
# /etc/letsencrypt/live/<domain>/privkey.pem
```

### Azure application

1. Add an application: go to https://portal.azure.com, choose Azure Active Directory, select **App registrations** and then click on **New registration**.

2. Pick a name, check the supported account type(single-tenant, multi-tenant, etc). In the **Redirect URI** section create a new Web platform entry for each app that you want to protect by the oauth2 proxy(e.g. https://internal.yourcompanycom/oauth2/callback). Click **Register**.

3. Next we need to add group read permissions for the app registration, on the **API Permissions** page of the app, click on **Add a permission**, select **Microsoft Graph**, then select Application permissions, then click on Group and select **Group.Read.All**. Hit Add permissions and then on Grant admin consent (you might need an admin to do this).

4. Next, if you are planning to use v2.0 Azure Auth endpoint, go to the Manifest page and set "accessTokenAcceptedVersion": 2 in the App registration **manifest** file.

5. On the **Certificates & secrets** page of the app, add a new client secret and note down the value after hitting Add.

### Variables

AZURE_TENANT: Find the number in the Portal settings | Directories + Subscriptions.
UPSTREAM: This is a link to your application where Oauth will redirect requests. (http://app:port)
COOKIE_SECRET: Generated secret that you can generate with `cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1 | base64`.
CLIENT_ID: ID of the service principal that you creted in Azure application section.
CLIENT_SECRET: This is a secret created in the previous step in Azure application.
REDIRECT_URL: Domain and port, where the Oath is running.

## Deploy

Update `inventory` file with the host(s) you want to deploy on.

With all the previous steps that we did, we will gather the information for the variables:

```
ansible-playbook -i inventory deploy.yaml \
    -e AZURE_TENAT="<AZURE_TENANT>" \
    -e UPSTREAM="UPSTREAM" \
    -e COOKIE_SECRET="COOKIE_SECRET" \
    -e CLIENT_ID="CLIENT_ID" \
    -e CLIENT_SECRET="CLIENT_SECRET" \
    -e REDIRECT_URL="REDIRECT_URL"
    -e PATH_TO_CERTS="/etc/letsencrypt/live/<domain>"
```
