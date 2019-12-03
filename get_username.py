import requests
import sys

def load_pr_data(pr_number):
    url = "https://api.github.com/repos/redhat-performance/jetpack/pulls/" + pr_number
    r = requests.get(url = url)
    data = r.json()
    sys.stdout.write(data['head']['user']['login'])

load_pr_data(sys.argv[1])
