# BigDB

## VS Code

Use VS Code to open the folder PHP inside this project.  This folder contains an example PHP file and the necessary configuration to get the debugger working.

## PHP

Install the [PHP-Debug extension](https://marketplace.visualstudio.com/items?itemName=felixfbecker.php-debug).

You don't need to do any further configuration to get PHP or the debugger to work.

* The Debug configuration _Launch currently open script_ will launch the current script in the debugger.  This is useful to testing small scripts and examples.
* The Debug configuration _Listen for Xdebug_ will start the debugger and wait for your local webserver to launch a PHP script and connect to the running debugger.  Once you start developing your website, this will be the easiest deubg method to use.

## Copy code to webserver

In the terminal, type 
```
make copy
```

This will copy your PHP code to /srv/www/htdocs/php/PUNETID/BigDB

You can open this website in your VM via:

http://localhost/php/PUNETID/BigDB/

(hint: you can edit this README file to change PUNETID to your actual PUNETID so you can use the link above.)
