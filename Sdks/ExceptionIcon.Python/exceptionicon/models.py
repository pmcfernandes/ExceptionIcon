from datetime import datetime

class ExceptionInstance:
    def __init__(self, message: str, exc_type: str = '', stack_trace: str = '', occurred_at: datetime = None):
        self.message = message
        self.type = exc_type
        self.stack_trace = stack_trace
        self.occurred_at = occurred_at or datetime.utcnow()

    def to_dict(self):
        return {
            'message': self.message,
            'type': self.type,
            'stackTrace': self.stack_trace,
            'timeOccurred': self.occurred_at.isoformat()
        }
