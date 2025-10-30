# ExceptionIcon Python SDK

Minimal Python SDK for ExceptionIcon.

Install (recommended in a virtualenv):

```bash
python -m venv .venv
source .venv/bin/activate  # on Windows use `.venv\Scripts\activate`
pip install -r requirements.txt
# or install from local folder: pip install -e .
```

Usage example:

```python
from exceptionicon import ExceptionIconClient, ExceptionIconOptions, ExceptionInstance

opts = ExceptionIconOptions(url='http://localhost:44345', api_key='your-api-key')
client = ExceptionIconClient(opts)

inst = ExceptionInstance('Test exception from Python SDK', 'ValueError', 'stack trace here')
result = client.capture_exception(inst.to_dict())
print(result)
```

Notes

- This SDK uses `requests` for HTTP calls.
- The payload keys (`message`, `type`, `stackTrace`, `timeOccurred`) may be adapted to match your API schema.
