# Doorman: iOS
Doorman is an iOS PoC for Golgi, written by Ian, of the Golgi team. The User Interface was designed by me, 128keaton, and I also made it 'standalone'.

## Setup
First, install Cocoapods on your machine, if you are an iOS developer, this is a must-have already, so stop making fire with sticks and mud, and go cook with /butane/

Using Terminal (which is what REAL unix h5xez use), navigate to the downloaded folder (probably Doorman-iOS-Master if you downloaded from GitHub) and do:

	$ pod setup && pod install
	
Good? Excellente por favor.
Next, open the workspace file:
	 
	$ open *.xcworkspace
And Xcode should open the project. From now on, use the workspace file (as Cocoapods directed, but who READS anything nowadays?)

If you try to run the project, you'll see you are missing some files, your Golgi app key, dev key, and your configuration.

Your configuration should look something like this:

	# Doorman configuration file

	# address for the granter of permanent keys
	ADDR=doorman@example.com

	# pin used to authenticate permanent key requests
	PIN=0000

	# password for server side MySQL user
	MYSQL_PWD=PASSWORD



Just make a file, e.g:

	$ nano Doorman.conf 
	
Inside the project directory and paste the contents above.

Then, run:
	
	$ nano Golgi.DevKey && Golgi.AppKey
	
And paste your appropriate keys inside the files accordingly, or something, just don't be an idiot.

Lastly, if you want remote notifications, you have to register an App ID from the ADC. Yay $100 a year licence. 

## Congratulations
You did it, if you made it this far.
