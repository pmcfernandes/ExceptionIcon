# ExceptionIcon
Monitor and detect .NET exceptions web application and API built in C# and ReactJS
 
 This application can be used with C# API to capture all exceptions from your applications and centralize in a repository of exceptions. Interface is built in ReactJS

#### Example
	var client = new ExceptionIconClient(new ExceptionIconOptions() {
		ApiKey = "<your key>",
		Url = "<your url>"
	});

	try {
		Console.Write("de".ToInt32().ToString(); // Fire a error because "de" is not a number
	} catch (Exception ex) {
		client.CaptureException(new ExceptionInstance(ex));
	}	

#### Installation

1. Compile react code
	
		npm install && npm run build

2. Install API in IIS and copy JS of react build to IIS 
3. Now you must have server site working
4. Add Sdk to you application and configure a #example code

#### Application defaut password

To access react app username is admin and password is pedro