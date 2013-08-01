sinatra-svn
===========

Sinatra app for managing your code with SVN.  

Prerequisites
===========

You will need the `subversion` lib on your system. Also, you need to give the credencials by command line, as the app will use shell commands to manipulate the repository. (Just do a subversion checkout of your code in the shell first).  
You will need `ruby >= 1.9.*` installed, and the `bundler` gem. 

Installation steps
===========

Clone the repo, then:  

    bundle install
    rackup config.ru

Options
===========

The web interface has 4 options right now.  

*  Check status of your trunk or production repository
*  Commit files by picking to your trunk

The other 2 are based on a specific case. If you have 2 repositories, one is the developers trunk, and the another is the production ready repository, these commands shall help you.  

* Diff the two repositories, and see which files are different
* Commit your files by picking to your production