class ExceptionInstance {
  constructor(message, type = '', stackTrace = '', occurredAt = null) {
    this.message = message;
    this.type = type;
    this.stackTrace = stackTrace;
    this.timeOccurred = occurredAt ? new Date(occurredAt) : new Date();
  }

  toJSON() {
    return {
      message: this.message,
      type: this.type,
      stackTrace: this.stackTrace,
      timeOccurred: this.timeOccurred.toISOString()
    };
  }
}

module.exports = ExceptionInstance;
