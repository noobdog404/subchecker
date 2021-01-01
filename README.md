# subchecker
Take a list of domains and check weather the domain is working or not.
# Install
<pre><code>./setup.sh -install</code></pre>
# Uninstall
<pre><code>./setup.sh -uninstall</code></pre>
# Usage
<pre><code>
Usage: subchecker -l [domains.txt file] -o [default | output_file_name.txt] -t [time in seconds]
<br>Options:<br/> 
 -l text file containing list of subdomains<br>
 -o name of the output file to store live domains. You can also use default paramter<br>
 -v check the current version<br>
 -t set the timeout (in seconds.)<br>
 -i Take a list of domains and check weather its working or not
 <br>
Example: ./subchecker.sh -l domains.txt -o alive.txt
</code></pre>
