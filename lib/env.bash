ORACLE_HOME=/usr/lib/instantclient_11_2
SQLPLUS_HOME=$ORACLE_HOME
LD_LIBRARY_PATH=$ORACLE_HOME
NLS_LANG=AMERICAN_AMERICA.WE8ISO8859P1
NLS_CHARACTERSET=WE8ISO8859P1
unset NLS_CHARACTERSET

APP_BASE=/home/projetos/credishop
ANT_HOME=/home/programas/ant
CATALINA_HOME=/home/programas/tomcat

export CDPATH='.:$HOME:$HOME:/home/projetos:/home/projetos/rails:/home/projetos/java'

#JAVA_HOME=/home/programas/jdk1.6.0_20
JAVA_HOME=/home/programas/java
JDK_HOME=$JAVA_HOME
JRUBY_HOME=/home/programas/jruby-1.2.0


PATH="/sbin:/bin:/usr/sbin:/usr/local/lib:/home/constantino/bin:/usr/bin:/usr/X11R6/bin:/usr/local/sbin:/usr/local/bin:$JAVA_HOME/bin:$JDK_HOME/bin:$ANT_HOME/bin:$CATALINA_HOME/bin:$NLS_LANG:$LD_LIBRARY_PATH:$JRUBY_HOME/bin:$ORACLE_HOME"

export ORACLE_HOME SQLPLUS_HOME LD_LIBRARY_PATH NLS_LANG NLS_CHARACTERSET APP_BASE ANT_HOME CATALINA_HOME JAVA_HOME JDK_HOME JRUBY_HOME PATH CLASSPATH

export TERM=xterm-color

