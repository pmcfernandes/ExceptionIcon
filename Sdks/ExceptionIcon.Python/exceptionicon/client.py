import requests
from typing import Optional

class ExceptionIconClient:
    def __init__(self, options: 'ExceptionIconOptions'):
        self.options = options
        self.base_url = options.url.rstrip('/') + '/api/'
        self.timeout = options.timeout

    def capture_exception(self, payload: dict) -> Optional[dict]:
        headers = {'Accept': 'application/json'}
        if self.options.api_key:
            headers['Authorization'] = f"Bearer {self.options.api_key}"

        resp = requests.post(self.base_url + 'exceptions', json=payload, headers=headers, timeout=self.timeout)
        resp.raise_for_status()
        return resp.json()
