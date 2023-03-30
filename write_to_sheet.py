import gspread
from oauth2client.service_account import ServiceAccountCredentials

import sys
import datetime
import pytz

ba_timezone = pytz.timezone('America/Argentina/Buenos_Aires')
ba_time = datetime.datetime.now(ba_timezone)
ba_datetime = ba_time.isoformat()

pkey = sys.argv[2]
pkey = pkey.replace("\\n", "\r\n")

# define the credentials to access the Google API
scope = ['https://spreadsheets.google.com/feeds', 'https://www.googleapis.com/auth/drive']
gcreds = {
  "type": "service_account",
  "project_id": "personal-336015",
  "private_key_id": "a7e7332875235ad1275202b3625b03853a7088da",
  "private_key": f"-----BEGIN PRIVATE KEY-----\n{pkey}\n-----END PRIVATE KEY-----\n",
  "client_email": "471643677310-compute@developer.gserviceaccount.com",
  "client_id": "113870011532726294405",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/471643677310-compute%40developer.gserviceaccount.com"
}


creds = ServiceAccountCredentials.from_json_keyfile_dict(gcreds,scope)

commit_hash = sys.argv[3]
commit_name = sys.argv[4]
architecture = sys.argv[5]

# authorize the credentials and open the Google Sheet
client = gspread.authorize(creds)
sheet = client.open('Performance Metrics').sheet1

# get the performance metrics from the file specified as an argument
with open(sys.argv[1], 'r') as f:
    lines = f.read()[1:].splitlines()[2:]
    values = []
    for line in lines:
        values.append(line.split(';')[0])

# write the performance metrics to the Google Sheet

row = [commit_hash, commit_name,ba_datetime, architecture] + values

sheet.append_row(row)
