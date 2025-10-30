from exceptionicon import ExceptionIconClient, ExceptionIconOptions, ExceptionInstance

opts = ExceptionIconOptions(url='http://localhost:44345', api_key='your-api-key')
client = ExceptionIconClient(opts)

inst = ExceptionInstance('Test exception from Python SDK', 'ValueError', 'stack trace here')

try:
    result = client.capture_exception(inst.to_dict())
    print(result)
except Exception as e:
    print('Error:', e)
