import io
import json
import logging
import os
import requests

from fdk import response
from oauthlib.oauth2 import BackendApplicationClient
from requests.auth import HTTPBasicAuth
from requests_oauthlib import OAuth2Session

# get environment variables:
base_url = os.getenv('DB_ORDS_BASE')
oauth_url_suffix = os.getenv('DB_ORDS_SERVICE_OAUTH')
service_url_suffix = os.getenv('DB_ORDS_SERVICE')
client_id = os.getenv('DB_ORDS_CLIENT_ID')
client_secret = os.getenv('DB_ORDS_CLIENT_SECRET')

def get_service_url():
    return base_url + service_url_suffix

def get_token_url():
    return base_url + oauth_url_suffix

def get_authz_header():
    return {"Authorization":"Bearer " + get_token()}

def get_token_data():
    client = BackendApplicationClient(client_id = client_id)
    oauth = OAuth2Session(client = client)
    return oauth.fetch_token(
      token_url = get_token_url(),
      client_id = client_id,
      client_secret = client_secret
    )

def get_token():
    return get_token_data()['access_token']

def post_campaign_data(payload):
    headers = get_authz_header()
    headers.update({"content-type":"application/json"})
    return requests.post(get_service_url(), json = payload, headers = headers).json()

def handler(ctx, data: io.BytesIO=None):
    try:
        body = json.loads(data.getvalue())
    except (Exception, ValueError) as ex:
        logging.getLogger().info('error parsing json payload: ' + str(ex))

    return response.Response(
        ctx, response_data=json.dumps(post_campaign_data(body)),
        headers={"Content-Type": "application/json"}
    )
