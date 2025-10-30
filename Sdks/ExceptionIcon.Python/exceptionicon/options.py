class ExceptionIconOptions:
    def __init__(self, url: str = 'http://localhost:44345', api_key: str = '', timeout: int = 5):
        self.url = url
        self.api_key = api_key
        self.timeout = timeout

    def set_timeout(self, seconds: int):
        self.timeout = seconds
