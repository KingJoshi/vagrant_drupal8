vagrant drupal 8 configurations
===============
0. _**You need vagrant and virtual box already installed**_
1. ```git clone git@github.com:KingJoshi/vagrant_drupal8.git drupal8_test``` *(or fork and customize configurations)*
2. ```git submodule init``` *(initialize git submodules puppetlabs mysql, stdlib and drupal8)*
3. ```git submodule update``` *(get git submodule sources)*
4. edit hosts file on local host machine to point drupal8.test to 10.10.10.10 *(optional)*
5. ```vagrant up``` *(should set up virtual machine with apache running)*
6. open web browser and go to ```http://drupal8.test/``` *(or ```http://10.10.10.10/``` if you skipped step 4)*
7. Install drupal *(database name, user and password is **drupal** which is set in ```manifests/db.pp```)*
8. Configure site (site email, admin user, password, etc) 
9. Congratulations. Drupal 8 is up and running. You can play with it, test modules or even patch code!
